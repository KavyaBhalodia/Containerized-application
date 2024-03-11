data "aws_elb_service_account" "main" {
}
data "aws_caller_identity" "current" {
}

#S3 bucket for application load-balancer logs
resource "aws_s3_bucket" "containerized-application-alb-logs" {
  bucket   = var.bucket-name
  tags = {
    Name = var.bucket-name
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
 
  bucket   = aws_s3_bucket.containerized-application-alb-logs.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


#S3 bucket-policy for accessing ALB logs
resource "aws_s3_bucket_policy" "s3-bucket-policy" {

  bucket   = aws_s3_bucket.containerized-application-alb-logs.id
  policy   = data.aws_iam_policy_document.s3-bucket-policy.json
}
data "aws_iam_policy_document" "s3-bucket-policy" {

  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_elb_service_account.main.id}:root"]
    }
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.containerized-application-alb-logs.bucket}/${var.alb-logs-prefix}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
  }
}