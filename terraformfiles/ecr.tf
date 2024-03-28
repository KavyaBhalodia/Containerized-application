#module for ECR
module "ecr" {
  source         = "./modules/ecr"
  ecr_repository = "${local.env}-containerized_app_repository"
  region         = "us-west-2"
  providers = {
    aws = aws.sandbox
  }
}

