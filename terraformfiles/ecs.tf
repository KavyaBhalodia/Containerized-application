#module for ECS
module "ecs" {
  source           = "./modules/ecs"
  container_name   = "containerized_app_container"
  base   = 1
  weight = 100
  cpu                    = 1024
  memory                 = 2048
  container_port         = 3000
  host_port              = 3000
  container_log_grp_name = "containerized_app_log_grp"
  ecs_service_name       = "containerized_app_service"
  environment_variable = {
    DB_HOST        = "${local.host}"
    DB_PASSWORD    = "${local.password}"
    DB_USER        = "${local.username}"
    DB_PORT        = "${local.port}"
    SESSION_SECRET = "${local.secret}"
  }
  image_url       = module.ecr.image_url
  target_grp_arn  = module.alb.target_grp_arn
  private_subnets = module.vpc.private_subnets
  ecs_sg_id       = [module.ecs_security_group.sg_id]
  role_arn        = data.aws_iam_role.my_ecstask_role.arn
  bucket          = "kavya-module-bucket"
  region          = "us_west_2"
  key             = "state/terraform.tfstate"
  ecs_cluster_id = module.ecs_cluster.ecs_cluster_id
  providers = {
    aws = aws.sandbox
  }
}

