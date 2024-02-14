//cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
//capacity provider
resource "aws_ecs_cluster_capacity_providers" "ecs-capacity-provider" {
  cluster_name = aws_ecs_cluster.ecs-cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
developer
    capacity_provider = "FARGATE"
    base              = 1
    weight            = 100

    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
main
  }
}
//task-definition
resource "aws_ecs_task_definition" "task" {
 developer
  family                   = "service"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = data.aws_iam_role.my-ecstask-role.arn

  container_definitions = jsonencode([
    {
      name      = "task-1"
      image     = "831794387446.dkr.ecr.ap-south-1.amazonaws.com/images:latest"
      cpu       = 256

  family = "service"
  container_definitions = jsonencode([
    {
      name      = "first-task"
      image     = "nginxhellos/demo"
      cpu       = 10
 main
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
 developer
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}
//task-service
resource "aws_ecs_service" "ecs-service-1" {
  name            = "ecs-service-1"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1


  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-target-grp.arn
    container_name   = "task-1"
    container_port   = 80
  }
  network_configuration {
    subnets         = aws_subnet.private-subnet.*.id
    security_groups = [aws_security_group.ecs-sg.id]
  }
}
data "aws_iam_role" "my-ecstask-role" {
  name = "ecsTaskExecutionRole"
}


  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }
}
//task-service
resource "aws_ecs_service" "ecs-service" {
  name            = "ecs-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs-role.arn
  depends_on      = [aws_iam_role_policy.ecs-policy]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

    load_balancer {
      target_group_arn = aws_lb_target_group.ecs-target-grp.arn
      container_name   = "task-1"
      container_port   = 80
    }
  network_configuration {
    
    subnets = aws_subnet.public-subnet.*.id
    security_groups = [aws_security_group.ecs-sg.id]
  }
}
resource "aws_iam_role_policy" "ecs-policy" {
  name = "ecs-policy"
  role = aws_iam_role.ecs-role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
resource "aws_iam_role" "ecs-role" {
  name = "ecs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecr.amazonaws.com"
        }
      },
    ]
  })
}
 main
