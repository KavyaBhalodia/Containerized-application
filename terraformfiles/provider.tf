provider "aws" {
  region = "ap-south-1"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
  backend "s3" {

    bucket  = "kavya-tfstate"
    key     = "state/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
    # dynamodb_table = "containerized-application-tf-lockID"
  }
}

