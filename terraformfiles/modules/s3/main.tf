data "aws_elb_service_account" "main" {
}
data "aws_caller_identity" "current" {
}

#S3 bucket for application load-balancer logs
resource "aws_s3_bucket" "containerized_application_alb_logs" {
  bucket   = var.bucket_name
  tags = {
    Name = var.bucket_name
  }
}

#S3 bucket-policy for accessing ALB logs
resource "aws_s3_bucket_policy" "s3_bucket_policy" {

  bucket   = aws_s3_bucket.containerized_application_alb_logs.id
  policy   = data.aws_iam_policy_document.s3_bucket_policy.json
}
data "aws_iam_policy_document" "s3_bucket_policy" {

  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_elb_service_account.main.id}:root"]
    }
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.containerized_application_alb_logs.bucket}/${var.alb_logs_prefix}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
  }
}