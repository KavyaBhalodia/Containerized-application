##############################################################################################################################
#                                                                                                                            #
#                                               ECS-CLUSTER                                                                  #
#                                                                                                                            #
##############################################################################################################################

resource "aws_ecs_cluster" "containerized-application-ecs-cluster" {
  name = "containerized-application-ecs-cluster"
  provider = aws.sandbox
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
############################################## ECS capacity provider ###########################################################

resource "aws_ecs_cluster_capacity_providers" "containerized-application-ecs-capacity-provider" {
  cluster_name = aws_ecs_cluster.containerized-application-ecs-cluster.name
  provider = aws.sandbox
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 1
    weight            = 100
  }
}

############################################## ECS task definition #############################################################

resource "aws_ecs_task_definition" "containerized-application-task" {
  family                   = "service"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  network_mode             = "awsvpc"
  execution_role_arn       = data.aws_iam_role.my-ecstask-role.arn
  provider = aws.sandbox

  container_definitions = jsonencode([
    {
      name      = "containerized-application-task"
      image     = "843728461002.dkr.ecr.us-west-2.amazonaws.com/containerized-application-repository:latest"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

################################################ ECS service ##########################################################

resource "aws_ecs_service" "containerized-application-ecs-service" {
  name            = "containerized-application-ecs-service"
  cluster         = aws_ecs_cluster.containerized-application-ecs-cluster.id
  task_definition = aws_ecs_task_definition.containerized-application-task.arn
  desired_count   = 1
  provider = aws.sandbox


  load_balancer {
    target_group_arn = aws_lb_target_group.conainerized-application-tg.arn
    container_name   = "containerized-application-task"
    container_port   = 80
  }
  network_configuration {
    subnets         = aws_subnet.private-subnet.*.id
    security_groups = [aws_security_group.ecs-sg.id]
  }
}

################################################ ECS task role ###########################################################

data "aws_iam_role" "my-ecstask-role" {
  provider = aws.sandbox
  name = "ecsTaskExecutionRole"
}
