locals {
  password = data.aws_ssm_parameter.password.value
  username = data.aws_ssm_parameter.username.value
  host     = data.aws_ssm_parameter.host.value
  port     = data.aws_ssm_parameter.port.value
  secret   = data.aws_ssm_parameter.secret.value
}
