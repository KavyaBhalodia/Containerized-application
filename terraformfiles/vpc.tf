
module "vpc" {
  source              = "./modules/vpc"
  vpc_name            = "containerized_application_vpc"
  private_subnet_name = "private_subnet"
  public_subnet_name  = "public_subnet"
  private_rt_name     = "private_rt"
  public_rt_name      = "public_rt"
  private_subnet_cidr = ["10.0.16.0/24", "10.0.32.0/24"]
  public_subnet_cidr  = ["10.0.0.0/24", "10.0.1.0/24"]
  ig_name             = "Internet_gateway"
  NatGW_name          = "Nat_gateway"
  az                  = ["us-west-2a", "us-west-2b"]

  providers = {
    aws = aws.sandbox
  }
}


