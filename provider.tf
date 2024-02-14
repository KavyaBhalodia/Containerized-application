
provider "aws" {
  region = "ap-south-1"
}
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"

    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

