
module "bastion-host-name" {
  source = "./modules/bastion-host.tf"
  bastion-host-name = "containered-app-bastion-host"
  subnet-id = "${module.vpc.public-subnet-id}"
  bastion-host-sg = "${module.bastion-host-security-group.bastion-host-sg}"
  providers = {
    aws=aws.sandbox
  }
}
