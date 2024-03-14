
#ECS_cluster
resource "aws_ecs_cluster" "containerized_application_ecs_cluster" {
  name     = var.ecs_cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }  
}

#ECS_capacity_provider
resource "aws_ecs_cluster_capacity_providers" "containerized_application_ecs_capacity_provider" {
  cluster_name       = aws_ecs_cluster.containerized_application_ecs_cluster.name
  capacity_providers = ["FARGATE","FARGATE_SPOT"]
  dynamic "default_capacity_provider_strategy" {
    for_each = var.default_capacity_providers
    content {
      capacity_provider = default_capacity_provider_strategy.value.capacity_provider
      base = default_capacity_provider_strategy.value.base
      weight = default_capacity_provider_strategy.value.weight
    }
  }
}