#module for S3
module "s3" {
  source          = "./modules/s3"
  bucket_name     = "${local.env}-containerized-app-alb-logs-bucket-1"
  alb_logs_prefix = "alblogs"
  providers = {
    aws = aws
  }
}