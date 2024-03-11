output "access-log-bucket" {
  value = aws_s3_bucket.containerized-application-alb-logs.bucket
}