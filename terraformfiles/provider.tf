provider "aws" {
  region = "ap-south-1"
}
provider "aws" {
  alias  = "sandbox"
  region = "us-west-2"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
  backend "s3" {
    profile = "sandbox"
    bucket  = "kavya-module-bucket"
    key     = "state/terraform.tfstate"
    region  = "us-west-2"
    //dynamodb_table = "containerized-application-tf-lockID"
  }
}

