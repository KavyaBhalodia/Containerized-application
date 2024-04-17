output "access_log_bucket" {
  value = aws_s3_bucket.containerized_application_alb_logs.bucket
}