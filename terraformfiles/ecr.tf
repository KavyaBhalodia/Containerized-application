
module "ecr" {
  source = "./modules/ecr"
  ecr-repository =  "containerized-app-repository"
  region = "us-west-2"
  providers = {
    aws=aws.sandbox
  }
}

