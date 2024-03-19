#module for Application load balancer
module "alb" {
  source            = "./modules/alb"
  alb_name          = "${local.env}-containerized-app-alb"
  listener_port     = 80
  target_group_name = "${local.env}-containerized-app-tg"
  alb_sg            = [module.alb_security_group.sg_id]
  public_subnets    = module.vpc.public_subnets
  access_log_bucket = module.s3.access_log_bucket
  vpc_id            = module.vpc.vpc_id
  alb_logs_prefix = "alblogs"
  providers = {
    aws = aws.sandbox
  }
}





