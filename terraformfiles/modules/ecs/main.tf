data "aws_iam_role" "my-ecstask-role" {
  name     = "ecsTaskExecutionRole"
}
#ECS cluster
resource "aws_ecs_cluster" "containerized-application-ecs-cluster" {
  name     = var.ecs-cluster-name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

#ECS capacity provider 
resource "aws_ecs_cluster_capacity_providers" "containerized-application-ecs-capacity-provider" {
  cluster_name       = aws_ecs_cluster.containerized-application-ecs-cluster.name
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = var.base
    weight            = var.weight
  }

}

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
resource "aws_ecs_task_definition" "containerized-application-task" {
  family                   = "service"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  execution_role_arn       = data.aws_iam_role.my-ecstask-role.arn


  container_definitions = jsonencode([
    {
      name      = var.container-name
      image     = var.image-url
      cpu       = var.cpu
      memory    = var.memory
      essential = true

      portMappings = [
        {
          containerPort = var.container-port
          hostPort      = var.host-port
        }
      ]
       environment = "${local.environment}"
      //[
      #   {
      #     name  = "DB_HOST"
      #     value = "kavya-database.ckddpdbqvvn5.us-west-2.rds.amazonaws.com"
      #   },
      #   {
      #     name  = "DB_USER"
      #     value = "postgres"
      #   },
      #   {
      #     name  = "DB_PASSWORD"
      #     value = "kavyabhalodia"
      #   },
      #   {
      #     name  = "DB_PORT"
      #     value = "5432"
      #   },
      #   {
      #     name  = "DB_DATABASE",
      #     value = "postgres"
      #   },
      #   {
      #     name  = "SESSION_SECRET"
      #     value = "secret"
      #   }
      # ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.container-log-grp-name
          "awslogs-region"        = "us-west-2"
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
  name=var.container-log-grp-name

  tags = {
    Environment = "Dev"
    Application = "service"
  }
}
#ECS service
resource "aws_ecs_service" "containerized-application-ecs-service" {
  name            = var.ecs-service-name
  cluster         = aws_ecs_cluster.containerized-application-ecs-cluster.id
  task_definition = aws_ecs_task_definition.containerized-application-task.arn
  desired_count   = 1
 

  load_balancer {
    target_group_arn = var.target-grp-arn
    container_name   = var.container-name
    container_port   = var.container-port
  }
  network_configuration {
    //subnets         = aws_subnet.private-subnet.*.id
    subnets         = var.private-subnets
    security_groups = var.ecs-sg-id
  }


}

