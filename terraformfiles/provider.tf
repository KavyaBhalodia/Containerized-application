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
    access_key = "AKIA4DKWPDH3GXUAHPMR"
    secret_key = "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"
    
    # dynamodb_table = "containerized-application-tf-lockID"
  }
}

