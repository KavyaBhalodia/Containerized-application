
module "alb-security-group" {
  source = "./modules/security-group"

  vpc-id  = module.vpc.vpc-id
  sg-name = "containerized-app-alb-sg"

  ingress_rules = [
    {
      from_port = 80, to_port = 80, cidr_blocks = ["0.0.0.0/0"], ipv6_cidr_blocks = ["::/0"]
    },
    {
      from_port = 443, to_port = 443, cidr_blocks = ["0.0.0.0/0"], ipv6_cidr_blocks = ["::/0"]
    }
  ]
  egress_rules = [
    {
      from_port = 0, to_port = 0
    },
    {
      from_port = 0, to_port = 0
    }
  ]

  providers = {
    aws = aws.sandbox
  }
}

module "ecs-security-group" {
  source  = "./modules/security-group"
  vpc-id  = module.vpc.vpc-id
  sg-name = "containerized-app-ecs-sg"
  ingress_rules = [
    {
      from_port = 80, to_port = 3000, cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port = 443, to_port = 3000, ipv6_cidr_blocks = ["::/0"]
    }
  ]
  egress_rules = [
    {
      from_port = 0, to_port = 0
    }
  ]
  #  ingress_sg = [
  #   {
  #     from_port = 0,to_port = 0
  #   }
  #  ]


  providers = {
    aws = aws.sandbox
  }
}

module "rds-security-group" {
  source  = "./modules/security-group"
  vpc-id  = module.vpc.vpc-id
  sg-name = "containerized-app-rds-sg"
  ingress_rules = [
    {
      from_port = 3000, to_port = 5432, cidr_blocks = ["0.0.0.0/0"], ipv6_cidr_blocks = ["::/0"]
    }
  ]
  egress_rules = [
    {
      from_port = 0, to_port = 0
    },
  ]
  providers = {
    aws = aws.sandbox
  }
}

module "bastion-host-security-group" {
  source  = "./modules/security-group"
  vpc-id  = module.vpc.vpc-id
  sg-name = "containerized-app-rds-sg"
  ingress_rules = [
    {
      from_port = 22, to_port = 22, cidr_blocks = ["0.0.0.0/0"], ipv6_cidr_blocks = ["::/0"]
    },
    {
      from_port = 80, to_port = 5432, cidr_blocks = ["0.0.0.0/0"], ipv6_cidr_blocks = ["::/0"]
    }
  ]
  egress_rules = [
    {
      from_port = 0, to_port = 0
    },
  ]
  providers = {
    aws = aws.sandbox
  }
}
