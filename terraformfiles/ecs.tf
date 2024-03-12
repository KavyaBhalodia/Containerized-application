
module "ecs" {
  source                 = "./modules/ecs"
  ecs-cluster-name       = "containerized-app-ecs-cluster"
  container-name         = "containerized-app-container"
  base                   = 1
  weight                 = 100
  cpu                    = 1024
  memory                 = 2048
  container-port         = 3000
  host-port              = 3000
  container-log-grp-name = "containerized-app-log-grp"
  ecs-service-name       = "containerized-app-service"
  environment_variable = {
    DB_HOST        = "${data.aws_ssm_parameter.host.value}"
    DB_PASSWORD    = "${data.aws_ssm_parameter.password.value}"
    DB_USER        = "${data.aws_ssm_parameter.username.value}"
    DB_PORT        = "${data.aws_ssm_parameter.port.value}"
    SESSION_SECRET = "${data.aws_ssm_parameter.secret.value}"
  }
  image-url = "${module.ecr.image-url}"
  target-grp-arn = "${module.alb.target-grp-arn}"
  private-subnets = "${module.vpc.private-subnets}"
  ecs-sg-id = "${module.ecs-security-group.ecs-sg-id}"
  role-arn = "${data.aws_iam_role.my-ecstask-role.arn}"
  bucket = "kavya-module-bucket"
  region = "us-west-2"
  key = "state/terraform.tfstate"
  providers = {
    aws=aws.sandbox
  }
}

