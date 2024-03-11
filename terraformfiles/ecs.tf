
# #ECS cluster
# resource "aws_ecs_cluster" "containerized-application-ecs-cluster" {
#   name     = "containerized-application-ecs-cluster"
#   provider = aws.sandbox
#   setting {
#     name  = "containerInsights"
#     value = "enabled"
#   }

# }

# #ECS capacity provider 
# resource "aws_ecs_cluster_capacity_providers" "containerized-application-ecs-capacity-provider" {
#   cluster_name       = aws_ecs_cluster.containerized-application-ecs-cluster.name
#   provider           = aws.sandbox
#   capacity_providers = ["FARGATE"]

#   default_capacity_provider_strategy {
#     capacity_provider = "FARGATE"
#     base              = 1
#     weight            = 100
#   }

# }

# #ECS task definition 
# resource "aws_ecs_task_definition" "containerized-application-task" {
#   family                   = "service"
#   requires_compatibilities = ["FARGATE"]
#   cpu                      = "1024"
#   memory                   = "2048"
#   network_mode             = "awsvpc"
#   execution_role_arn       = data.aws_iam_role.my-ecstask-role.arn
#   provider                 = aws.sandbox

#   container_definitions = jsonencode([
#     {
#       name      = "containerized-application-task"
#       image     = "${aws_ecr_repository.containerized-application-repository.repository_url}"
#       cpu       = 1024
#       memory    = 2048
#       essential = true

#       portMappings = [
#         {
#           containerPort = 3000
#           hostPort      = 3000
#         }
#       ]
#       environment = [
#         {
#           name  = "DB_HOST"
#           value = "kavya-database.ckddpdbqvvn5.us-west-2.rds.amazonaws.com"
#         },
#         {
#           name  = "DB_USER"
#           value = "postgres"
#         },
#         {
#           name  = "DB_PASSWORD"
#           value = "kavyabhalodia"
#         },
#         {
#           name  = "DB_PORT"
#           value = "5432"
#         },
#         {
#           name  = "DB_DATABASE",
#           value = "postgres"
#         },
#         {
#           name  = "SESSION_SECRET"
#           value = "secret"
#         }
#       ]
#       logConfiguration = {
#         logDriver = "awslogs"
#         options = {
#           "awslogs-group"         = "container-logs"
#           "awslogs-region"        = var.region
#           "awslogs-stream-prefix" = "alb-logs"
#         }
#       }
#     }
#   ])
#   runtime_platform {
#     operating_system_family = "LINUX"
#     cpu_architecture        = "X86_64"
#   }

# }
# resource "aws_cloudwatch_log_group" "container-logs" {
#   provider = aws.sandbox
#   name     = "container-logs"

#   tags = {
#     Environment = "Dev"
#     Application = "service"
#   }
# }

# resource "aws_cloudwatch_log_stream" "log-stream" {
#   provider       = aws.sandbox
#   name           = "container-log-stream"
#   log_group_name = aws_cloudwatch_log_group.container-logs.name
# }
# #ECS service
# resource "aws_ecs_service" "containerized-application-ecs-service" {
#   name            = "containerized-application-ecs-service"
#   cluster         = aws_ecs_cluster.containerized-application-ecs-cluster.id
#   task_definition = aws_ecs_task_definition.containerized-application-task.arn
#   desired_count   = 1
#   provider        = aws.sandbox

#   load_balancer {
#     target_group_arn = aws_lb_target_group.containerized-application-tg.arn
#     container_name   = "containerized-application-task"
#     container_port   = 3000
#   }
#   network_configuration {
#     subnets         = aws_subnet.private-subnet.*.id
#     security_groups = [aws_security_group.ecs-sg.id]
#   }


# }

# #ECS task role
# data "aws_iam_role" "my-ecstask-role" {
#   provider = aws.sandbox
#   name     = "ecsTaskExecutionRole"
# }
module "ecs" {
  source                 = "./modules/ecs"
  ecs-cluster-name       = "containerized-app-ecs-cluster"
  container-name         = "containerized-app-container"
  base                   = 1
  weight                 = 100
  cpu                    = 1024
  memory                 = 2048
  container-port         = 3000
  host-port              = 3000
  container-log-grp-name = "containerized-app-log-grp"
  ecs-service-name       = "containerized-app-service"
  environment_variable = {
    DB_HOST        = "${module.database.db-identifier}.ckddpdbqvvn5.${module.ecr.region}.rds.amazonaws.com"
    DB_PASSWORD    = module.database.db-password
    DB_USER        = module.database.username
    DB_PORT        = "5432"
    SESSION_SECRET = "secret"
  }
  image-url = module.ecr.image-url
  target-grp-arn = module.alb.target-grp-arn
  private-subnets = module.vpc.private-subnets
  ecs-sg-id = module.security-group.ecs-sg-id
  providers = {
    aws=aws.sandbox
  }
}

