provider "aws" {
  region = "ap-south-1"
}
terraform {
  backend "s3" {

    bucket  = "kavya-tfstate"
    key     = "state/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
    //dynamodb_table = "containerized-application-tf-lockID"
  }
}

provider "external" {

}