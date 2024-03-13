module "ecs_cluster" {
  source = "./modules/ecs_cluster"
  ecs-cluster-name = "containerized-app-ecs-cluster"
  providers = {
    aws=aws.sandbox
  }
}