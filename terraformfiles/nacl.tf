module "nacl" {
  source         = "./modules/nacl"
  vpc_nacl       = module.vpc.vpc_nacl
  ingress_rules = [
    {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    }

  ]

  egress_rules = [
    {
      protocol   = "all"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0

    }
  ]

}