
#ECS_cluster
resource "aws_ecs_cluster" "containerized_app_ecs_cluster" {
  name     = var.ecs_cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }  
  # lifecycle {
  #   prevent_destroy = true
  # }
}

#ECS_capacity_provider
resource "aws_ecs_cluster_capacity_providers" "containerized_app_ecs_capacity_provider" {
  cluster_name       = aws_ecs_cluster.containerized_app_ecs_cluster.name
  capacity_providers = ["FARGATE","FARGATE_SPOT"]

}