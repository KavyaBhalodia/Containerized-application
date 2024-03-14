
data "aws_iam_role" "my_ecstask_role" {
  name     = "ecsTaskExecutionRole"
  provider = aws.sandbox
}

data "aws_ssm_parameter" "password" {
  name     = "/kavya/rds/db_password"
  provider = aws.sandbox
}
data "aws_ssm_parameter" "username" {
  name     = "/kavya/rds/db_username"
  provider = aws.sandbox
}
data "aws_ssm_parameter" "port" {
  name     = "/kavya/rds/port"
  provider = aws.sandbox
}
data "aws_ssm_parameter" "host" {
  name     = "/kavya/rds/host"
  provider = aws.sandbox
}
data "aws_ssm_parameter" "secret" {
  name     = "/kavya/rds/session_secret"
  provider = aws.sandbox
}
