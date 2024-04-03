
module "vpc" {
  source              = "./modules/vpc"
  vpc_name            = "${local.env}-containerized_application_vpc"
  private_subnet_name = "${local.env}-private_subnet"
  public_subnet_name  = "${local.env}-public_subnet"
  private_rt_name     = "${local.env}-private_rt"
  public_rt_name      = "${local.env}-public_rt"
  private_subnet_cidr = ["10.0.16.0/24", "10.0.32.0/24"]
  public_subnet_cidr  = ["10.0.0.0/24", "10.0.1.0/24"]
  ig_name             = "${local.env}-Internet_gateway"
  NatGW_name          = "${local.env}-Nat_gateway"
  az                  = var.az

  providers = {
    aws = aws
  }
}

