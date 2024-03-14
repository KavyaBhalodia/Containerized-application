
#local block to map envirnment values
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

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.container_log_grp_name
          "awslogs-region"        = "us-west-2"
          "awslogs-stream-prefix" = "alblogs"
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

}


