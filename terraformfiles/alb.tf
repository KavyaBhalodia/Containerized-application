
module "alb" {
  source = "./modules/alb"
  alb-name = "containerized-app-alb"
  prefix = "aws-logs"
  listener-port = 80
  target-group-name = "containerized-app-tg"
  alb-sg = "${module.alb-security-group.alb-sg}"
  public-subnets = "${module.vpc.public-subnets}"
  access-log-bucket = "${module.s3.access-log-bucket}"
  vpc-id = "${module.vpc.vpc-id}"
  providers = {
    aws=aws.sandbox
  }
}





