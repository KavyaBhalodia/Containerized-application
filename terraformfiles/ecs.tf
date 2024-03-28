#local variables that refer to ssm parameters
locals {
  DB_HOST        = data.aws_ssm_parameter.host.arn
  DB_PASSWORD    = data.aws_ssm_parameter.password.arn
  DB_USER        = data.aws_ssm_parameter.username.arn
  DB_PORT        = data.aws_ssm_parameter.port.arn
  SESSION_SECRET = data.aws_ssm_parameter.secret.arn
}

#module for ECS
module "ecs" {
  source                 = "./modules/ecs"
  container_name         = "${local.env}-containerized_app_container"
  base                   = 1
  weight                 = 100
  cpu                    = 512
  memory                 = 1024
  container_port         = 3000
  host_port              = 3000
  container_log_grp_name = "${local.env}-containerized_app_log_grp"
  ecs_service_name       = "${local.env}-containerized_app_service"
  environment_variable = {
    DB_PORT        = "${local.DB_PORT}"
    SESSION_SECRET = "${local.SESSION_SECRET}"

  }
  secret_variables = {
    DB_PASSWORD = "${local.DB_PASSWORD}"
    DB_USER     = "${local.DB_USER}"
    DB_HOST     = "${local.DB_HOST}"
  }

  image_url               = module.ecr.image_url
  target_grp_arn          = module.alb.target_grp_arn
  private_subnets         = module.vpc.private_subnets
  ecs_sg_id               = [module.ecs_security_group.sg_id]
  role_arn                = data.aws_iam_role.my_ecstask_role.arn
  region                  = "us_west_2"
  ecs_cluster_id          = module.ecs_cluster.ecs_cluster_id
  policy_name             = "ecs-autoscaling-policy"
  target                  = 2
  scale_in_cooldown       = 30
  scale_out_cooldown      = 30
  cluster_name            = module.ecs_cluster.ecs_cluster_name
  alb_arn_suffix          = module.alb.alb_arn_suffix
  target_group_arn_suffix = module.alb.target_grp_arn_suffix
  providers = {
    aws = aws.sandbox
  }
}

