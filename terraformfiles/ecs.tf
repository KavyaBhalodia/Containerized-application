
#module for ECS
module "ecs" {
  source                 = "./modules/ecs"
  container_name         = "${local.env}-containerized_app_container"
  cpu                    = 512
  memory                 = 1024
  container_port         = 3000
  host_port              = 3000
  container_log_grp_name = "${local.env}-containerized_app_log_grp"
  ecs_service_name       = "${local.env}-containerized_app_service"
  environment_variable = {
    SESSION_SECRET = "${local.SESSION_SECRET.name}"
  }
  secret_variables = {
    DB_PASSWORD = "${local.DB_PASSWORD.name}"
    DB_USER     = "${local.DB_USER.name}"
    DB_HOST     = "${local.DB_HOST.name}"
    DB_PORT     = "${local.DB_PORT.name}"
    DB_DATABASE = "${local.DB_DATABASE_NAME.name}"
  }

  image_url               = module.ecr.image_url
  target_grp_arn          = module.alb.target_grp_arn
  private_subnets         = module.vpc.private_subnets
  ecs_sg_id               = [module.ecs_security_group.sg_id]
  role_arn                = data.aws_iam_role.my_ecstask_role.arn
  region                  = var.region
  ecs_cluster_id          = module.ecs_cluster.ecs_cluster_id
  policy_name             = "ecs-autoscaling-policy"
  target                  = 2
  scale_in_cooldown       = 30
  scale_out_cooldown      = 30
  cluster_name            = module.ecs_cluster.ecs_cluster_name
  alb_arn_suffix          = module.alb.alb_arn_suffix
  target_group_arn_suffix = module.alb.target_grp_arn_suffix
  log_stream_prefix       = "container-logs"
  default_capacity_providers = [
    {
      capacity_provider = "FARGATE", base = 1, weight = 100
    }
  ]
  autoscaling_grp = true
  providers = {
    aws = aws
  }
}

