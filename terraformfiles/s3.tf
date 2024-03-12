
module "s3" {
  source = "./modules/s3"
  bucket-name = "containerized-app-alb-logs-bucket"
  alb-logs-prefix = "${module.alb.alb-log-prefix}"
  providers = {
    aws=aws.sandbox
  }
}