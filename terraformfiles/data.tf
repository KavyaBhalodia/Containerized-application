data "aws_elb_service_account" "main" {
  provider = aws.sandbox
}
data "aws_iam_role" "my-ecstask-role" {
  name     = "ecsTaskExecutionRole"
  provider = aws.sandbox
}
data "aws_caller_identity" "current" {
  provider = aws.sandbox
}
