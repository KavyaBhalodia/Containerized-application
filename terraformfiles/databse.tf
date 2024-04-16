# #module for database
# module "database" {
#   source          = "./modules/database"
#   db_identifier   = "kavya-database"
#   password        = local.db_password
#   username        = local.db_username
#   subnet_grp_name = "postgres_subnet_grp"
#   public_subnets  = module.vpc.public_subnets
#   rds_sg          = [module.rds_security_group.sg_id]
#   az              = var.az[0]
#   providers = {
#     aws = aws
#   }
# }
