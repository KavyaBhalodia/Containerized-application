provider "aws" {
  region = "ap-south-1"
}
provider "aws" {
  alias  = "sandbox"
  region = "us-west-2"
}
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
    external = {
      source = "hashicorp/external"
    }

  }
  backend "s3" {
    profile = "sandbox"
    bucket         = "kavya-containerized-application-tfstate"
    key            = "state/terraform.tfstate"
    region         = "us-west-2"
    //dynamodb_table = "containerized-application-tf-lockID"
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

provider "external" {
  
}