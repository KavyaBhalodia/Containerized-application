
#ECS cluster
resource "aws_ecs_cluster" "containerized-app-ecs-cluster" {
  name = "${local.env}-containerized-app-ecs-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  provider = aws.sandbox

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
  provider = aws.sandbox
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
      enviroment = "${local.environment}"
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
  provider = aws.sandbox
}

resource "aws_cloudwatch_log_group" "container-logs" {
  name = "container-logs"
  tags = {
    Environment = "Dev"
    Application = "service"
  }
  provider = aws.sandbox
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
  provider = aws.sandbox
}

