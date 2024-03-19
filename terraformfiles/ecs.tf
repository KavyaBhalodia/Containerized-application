#local variables that refer to ssm parameters
locals {
  password = data.aws_ssm_parameter.password.value
  username = data.aws_ssm_parameter.username.value
  host     = data.aws_ssm_parameter.host.value
  port     = data.aws_ssm_parameter.port.value
  secret   = data.aws_ssm_parameter.secret.value
}

#module for ECS
module "ecs" {
  source           = "./modules/ecs"
  container_name   = "${local.env}-containerized_app_container"
  base   = 1
  weight = 100
  cpu                    = 512
  memory                 = 1024
  container_port         = 3000
  host_port              = 3000
  container_log_grp_name = "${local.env}-containerized_app_log_grp"
  ecs_service_name       = "${local.env}-containerized_app_service"
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
  region          = "us_west_2"
  ecs_cluster_id = module.ecs_cluster.ecs_cluster_id
  providers = {
    aws = aws.sandbox
  }
}

