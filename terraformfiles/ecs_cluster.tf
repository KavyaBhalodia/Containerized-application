#module for ECS-cluster
module "ecs_cluster" {
  source           = "./modules/ecs_cluster"
  ecs_cluster_name = "${local.env}-containerized_app_ecs_cluster"

  providers = {
    aws = aws
  }
}
