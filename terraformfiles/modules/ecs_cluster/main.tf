
#ECS-cluster
resource "aws_ecs_cluster" "containerized-application-ecs-cluster" {
  name     = var.ecs-cluster-name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }  
}

#ECS-capacity-provider
resource "aws_ecs_cluster_capacity_providers" "containerized-application-ecs-capacity-provider" {
  cluster_name       = aws_ecs_cluster.containerized-application-ecs-cluster.name
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