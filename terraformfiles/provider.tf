provider "aws" {
  region = "ap-south-1"
  profile = "kavya"
}
# provider "aws" {
#   alias  = "sandbox"
#   region = "us-west-2"
# }
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
  backend "s3" {
    profile = "kavya"
    bucket  = "kavya-tfstate"
    key     = "state/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
    # dynamodb_table = "containerized-application-tf-lockID"
  }
}

