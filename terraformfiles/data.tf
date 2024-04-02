data "aws_elb_service_account" "main" {
 
}
data "aws_iam_role" "my-ecstask-role" {
  name     = "ecsTaskExecutionRole"
  
}
data "aws_caller_identity" "current" {
  
}
