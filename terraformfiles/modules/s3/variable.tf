variable "bucket_name" {
  type = string
  description = "Name of the S3 bucket which will store access logs of ALB"
}
variable "alb_logs_prefix" {
  type = string
}
