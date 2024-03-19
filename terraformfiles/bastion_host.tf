#module for bastion_host
module "bastion_host_name" {
  source            = "./modules/bastion_host.tf"
  bastion_host_name = "${local.env}-containered_app_bastion_host"
  subnet_id         = module.vpc.public_subnet_id
  bastion_host_sg   = [module.bastion_host_security_group.sg_id]
  providers = {
    aws = aws.sandbox
  }
}
