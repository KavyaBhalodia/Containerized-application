
module "vpc" {
  source              = "./modules/vpc"
  vpc-name            = "containerized-application-vpc"
  private-subnet-name = "private-subnet"
  public-subnet-name  = "public-subnet"
  private-rt-name     = "private-rt"
  public-rt-name      = "public-rt"
  private_subnet_cidr = ["10.0.16.0/24", "10.0.32.0/24"]
  public_subnet_cidr  = ["10.0.0.0/24", "10.0.1.0/24"]
  ig-name             = "Internet-gateway"
  NatGW-name          = "Nat-gateway"
  az                  = ["us-west-2a", "us-west-2b"]

  providers = {
    aws = aws.sandbox
  }
}


