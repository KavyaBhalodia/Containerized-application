
module "ecs" {
  source           = "./modules/ecs"
  ecs-cluster-name= module.ecs_cluster.ecs-cluster-name
  container-name   = "containerized-app-container"
  default_capacity_providers = [
    {
      capacity_provider = "FARGATE", base = 1, weight = 100
    }
  ]
  base   = 1
  weight = 100

  cpu                    = 1024
  memory                 = 2048
  container-port         = 3000
  host-port              = 3000
  container-log-grp-name = "containerized-app-log-grp"
  ecs-service-name       = "containerized-app-service"
  environment_variable = {
    DB_HOST        = "${local.host}"
    DB_PASSWORD    = "${local.password}"
    DB_USER        = "${local.username}"
    DB_PORT        = "${local.port}"
    SESSION_SECRET = "${local.secret}"
  }
  image-url       = module.ecr.image-url
  target-grp-arn  = module.alb.target-grp-arn
  private-subnets = module.vpc.private-subnets
  ecs-sg-id       = [module.ecs-security-group.sg-id]
  role-arn        = data.aws_iam_role.my-ecstask-role.arn
  bucket          = "kavya-module-bucket"
  region          = "us-west-2"
  key             = "state/terraform.tfstate"
  ecs-cluster-id = module.ecs_cluster.ecs-cluster-id
  providers = {
    aws = aws.sandbox
  }
}

