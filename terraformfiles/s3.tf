#module for S3
module "s3" {
  source          = "./modules/s3"
  bucket_name     = "containerized-app-alb-logs-bucket"
  alb_logs_prefix = "alblogs"
  providers = {
    aws = aws.sandbox
  }
}