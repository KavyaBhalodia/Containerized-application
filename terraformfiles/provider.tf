provider "aws" {
  region = "ap-south-1"
}
provider "aws" {
  alias  = "sandbox"
  region = "us-west-2"
}
terraform {
  backend "s3" {
    profile = "sandbox"
    bucket  = "kavya-containerized-app-tfstate"
    key     = "state/terraform.tfstate"
    region  = "us-west-2"
    dynamodb_table = "containerized-application-tf-lockID"
  }
}

provider "external" {

}