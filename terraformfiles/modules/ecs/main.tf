

#local block to map envirnment values
locals {
  environment = flatten([
    for name, value in var.environment_variable : [
      {
        
        name  = name
        value = value
      }
      
  ]])
    secret = flatten([
    for name, value in var.secret_variables : [
      {
        name  = name
        valueFrom = value
      }
  ]]
  )
}

#ECS task definition 
resource "aws_ecs_task_definition" "containerized_application_task" {
  family                   = "service"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  execution_role_arn       = var.role_arn


  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image_url
      cpu       = var.cpu
      memory    = var.memory
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
        }
      ]
      environment = "${local.environment}"
      secrets="${local.secret}"
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.container_log_grp_name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = var.log_stream_prefix
        }
      }
    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

}
resource "aws_cloudwatch_log_group" "container_logs" {
  name=var.container_log_grp_name

  tags = {
    Environment = "Dev"
    Application = "service"
  }
}

#ECS service
resource "aws_ecs_service" "containerized_application_ecs_service" {
  name            = var.ecs_service_name
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.containerized_application_task.arn
  desired_count   = 1
  load_balancer {
    target_group_arn = var.target_grp_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
  network_configuration {
    subnets         = var.private_subnets
    security_groups = var.ecs_sg_id
  }
    dynamic "capacity_provider_strategy" {
    for_each = var.default_capacity_providers
    content {
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      base = capacity_provider_strategy.value.base
      weight = capacity_provider_strategy.value.weight
    }
  }
}
resource "aws_appautoscaling_target" "ecs_target" {
  count = var.autoscaling_grp ? 1 : 0
  max_capacity       = 3
  min_capacity       = 1
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.containerized_application_ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  role_arn = aws_iam_role.ECS-Autoscaling-role.arn
 
}

#autoscaling for fargate tasks
resource "aws_appautoscaling_policy" "ecs_policy" {
  count = var.autoscaling_grp ? 1 : 0
  name               = var.policy_name
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[0].service_namespace

 target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label = "${var.alb_arn_suffix}/${var.target_group_arn_suffix}"
    }
    target_value       = var.target
     scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
  
}
resource "aws_iam_role" "ECS-Autoscaling-role" {
  
  name = "ECS-Autosclaing-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "application-autoscaling.amazonaws.com"
        }
      },
    ]
  })
}

#Data source for IAM policy
data "aws_iam_policy" "aws-ecs-policy" {
 name = "AmazonEC2ContainerServiceAutoscaleRole" 
}
