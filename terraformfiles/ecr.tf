#module for ECR
module "ecr" {
  source         = "./modules/ecr"
  ecr_repository = "${local.env}-containerized_app_repository"
  region         = var.region
  providers = {
    aws = aws
  }
}

