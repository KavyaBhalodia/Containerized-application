module "ecs_cluster" {
  source = "./modules/ecs_cluster"
  ecs-cluster-name = "containerized-app-ecs-cluster"
   default_capacity_providers = [
    {
      capacity_provider = "FARGATE", base = 1, weight = 100
    }
  ]
  
  providers = {
    aws=aws.sandbox
  }
}