
#ECS cluster
resource "aws_ecs_cluster" "containerized-app-ecs-cluster" {
  name = "${local.env}-containerized-app-ecs-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }


}

#ECS capacity provider 
resource "aws_ecs_cluster_capacity_providers" "containerized-app-ecs-capacity-provider" {
  cluster_name       = aws_ecs_cluster.containerized-app-ecs-cluster.name
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 1
    weight            = 100
  }

}

#local block for enviroment variables 
locals {
  environment = flatten([
    for name, value in var.environment_variable : [
      {
        name  = name
        value = value
      }
  ]])
}

#ECS task definition 
resource "aws_ecs_task_definition" "containerized-app-task" {
  family                   = "service"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  network_mode             = "awsvpc"
  execution_role_arn       = data.aws_iam_role.my-ecstask-role.arn


  container_definitions = jsonencode([
    {
      name      = "${local.env}-containerized-app-task"
      image     = "${aws_ecr_repository.containerized-app-repository.repository_url}"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      environment = "${local.environment}"
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "container-logs"
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "alb-logs"
        }
      }

    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

}

resource "aws_cloudwatch_log_group" "container-logs" {
  name = "container-logs"
  tags = {
    Environment = "Dev"
    Application = "service"
  }

}

#ECS service
resource "aws_ecs_service" "containerized-app-ecs-service" {
  name            = "${local.env}-containerized-app-ecs-service"
  cluster         = aws_ecs_cluster.containerized-app-ecs-cluster.id
  task_definition = aws_ecs_task_definition.containerized-app-task.arn
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.containerized-app-tg.arn
    container_name   = "${local.env}-containerized-app-task"
    container_port   = 3000
  }

  network_configuration {
    subnets         = aws_subnet.private-subnet.*.id
    security_groups = [aws_security_group.ecs-sg.id]
  }

}
# resource "aws_appautoscaling_target" "ecs_target" {
#   max_capacity       = 3
#   min_capacity       = 1
#   resource_id        = "service/${aws_ecs_cluster.containerized-app-ecs-cluster.name}/${aws_ecs_service.containerized-app-ecs-service.name}"
#   scalable_dimension = "ecs:service:DesiredCount"
#   service_namespace  = "ecs"
#   role_arn           = aws_iam_role.ECS-Autoscaling-role.arn

# }

# resource "aws_appautoscaling_policy" "ecs_policy" {
#   name               = "task-auto-scaling-policy"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.ecs_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ALBRequestCountPerTarget"
#       resource_label         = "${aws_lb.containerized-app-alb.arn_suffix}/${aws_lb_target_group.containerized-app-tg.arn_suffix}"
#     }
#     target_value       = 2
#     scale_in_cooldown  = 30
#     scale_out_cooldown = 30
#   }

# }

# resource "aws_iam_role" "ECS-Autoscaling-role" {
#   name = "ECS-Autosclaing-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "application-autoscaling.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

#Data source for IAM policy
# data "aws_iam_policy" "aws-ecs-policy" {
#   name = "AmazonEC2ContainerServiceAutoscaleRole"


# }
# resource "aws_iam_policy" "ecs-policy" {
#   name = "ecs-policy"
#   path = "/"
#   description = "Allow access to the service elb"
#   policy = data.aws_iam_policy.aws-ecs-policy.policy_id
#   
# }

#policy for autoscaling
# resource "aws_iam_role_policy_attachment" "ecs_service_scaling" {
#   role       = aws_iam_role.ECS-Autoscaling-role.name
#   policy_arn = data.aws_iam_policy.aws-ecs-policy.arn

# }
output "name" {
  value = local.environment
}