
# #data source to get ecs role
# data "aws_iam_role" "my_ecstask_role" {
#   name     = "ecsTaskExecutionRole"
#   provider = aws
# }

# #data source to get ssm parameters
# data "aws_ssm_parameter" "password" {
#   name     = "/kavya/rds/db_password"
#   provider = aws
# }
# data "aws_ssm_parameter" "username" {
#   name     = "/kavya/rds/db_username"
#   provider = aws
# }
# data "aws_ssm_parameter" "port" {
#   name     = "/kavya/rds/port"
#   provider = aws
# }
# data "aws_ssm_parameter" "host" {
#   name     = "/kavya/rds/host"
#   provider = aws
# }
# data "aws_ssm_parameter" "secret" {
#   name     = "/kavya/rds/session_secret"
#   provider = aws
# }
# data "aws_ssm_parameter" "db_database" {
#   name     = "/kavya/rds/db_database"
#   provider = aws
# }
# #local variables that refer to ssm parameters
# locals {
#   DB_HOST        = data.aws_ssm_parameter.host.name
#   DB_PASSWORD    = data.aws_ssm_parameter.password.name
#   DB_USER        = data.aws_ssm_parameter.username.name
#   DB_PORT        = data.aws_ssm_parameter.port.name
#   SESSION_SECRET = data.aws_ssm_parameter.secret.name
#   DB_DATABASE    = data.aws_ssm_parameter.db_database.name
# }