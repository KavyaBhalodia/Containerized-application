#module for ECS-cluster
module "ecs_cluster" {
  source           = "./modules/ecs_cluster"
  ecs_cluster_name = "${local.env}-containerized_app_ecs_cluster"
  default_capacity_providers = [
    {
      capacity_provider = "FARGATE", base = 1, weight = 100
    }
  ]
  providers = {
    aws = aws
  }
}
