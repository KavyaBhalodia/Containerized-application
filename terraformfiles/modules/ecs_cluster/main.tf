resource "aws_ecs_cluster" "containerized-application-ecs-cluster" {
  name     = var.ecs-cluster-name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }  
}