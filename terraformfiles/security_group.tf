#module for ALB security group
module "alb_security_group" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
  sg_name = "${local.env}-containerized_app_alb_sg"
  ingress_rules = [
    {
      from_port        = 80,
      to_port          = 80,
      cidr_blocks      = ["0.0.0.0/0"],
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      from_port        = 443,
      to_port          = 443,
      cidr_blocks      = ["0.0.0.0/0"],
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
  egress_rules = [
    {
      from_port = 0,
      to_port   = 0
    },
    {
      from_port = 0,
      to_port   = 0
    }
  ]
  providers = {
    aws = aws.sandbox
  }
}

#module for ECS security group
module "ecs_security_group" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
  sg_name = "${local.env}-containerized_app_ecs_sg"
  ingress_rules = [
    {
      from_port   = 3000,
      to_port     = 3000,
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress_rules = [
    {
      from_port = 0,
      to_port   = 0
    }
  ]

  providers = {
    aws = aws.sandbox
  }
}

#module for RDS security group
module "rds_security_group" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
  sg_name = "${local.env}-containerized_app_rds_sg"
  ingress_rules = [
    {
      from_port        = 5432,
      to_port          = 5432,
      cidr_blocks      = ["0.0.0.0/0"],
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
  egress_rules = [
    {
      from_port = 0,
      to_port   = 0
    },
  ]
  providers = {
    aws = aws.sandbox
  }
}

#module for bastion-host security group
module "bastion_host_security_group" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
  sg_name = "${local.env}-containerized_app_bastion_host_sg"
  ingress_rules = [
    {
      from_port        = 22,
      to_port          = 22,
      cidr_blocks      = ["0.0.0.0/0"],
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
  egress_rules = [
    {
      from_port = 0,
      to_port   = 0
    },
  ]
  providers = {
    aws = aws.sandbox
  }
}
