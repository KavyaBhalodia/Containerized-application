variable "bucket-name" {
  type = string
  description = "Name of the S3 bucket which will store access logs of ALB"
}
variable "alb-logs-prefix" {
  type = string
}