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
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}


