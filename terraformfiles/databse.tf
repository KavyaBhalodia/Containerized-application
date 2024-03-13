
module "database" {
  source          = "./modules/database"
  db-identifier   = "kavya-database"
  password        = data.aws_ssm_parameter.password.value
  username        = data.aws_ssm_parameter.username.value
  subnet-grp-name = "postgres-subnet-grp"
  public-subnets  = module.vpc.public-subnets
  rds-sg          = [module.rds-security-group.sg-id]
  providers = {
    aws = aws.sandbox
  }
}
