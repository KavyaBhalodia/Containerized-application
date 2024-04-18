
resource "aws_default_network_acl" "default_nacl" {
  default_network_acl_id = var.vpc_nacl

  dynamic ingress {
    for_each = var.ingress_rules
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = try(coalesce(ingress.value.protocol, "tcp", null))
      rule_no = ingress.value.rule_no
      action = ingress.value.action
      cidr_block = ingress.value.cidr_block
    }
    
  }
dynamic egress {
    for_each = var.egress_rules
    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = try(coalesce(egress.value.protocol, "tcp", null))
      rule_no = egress.value.rule_no
      action = egress.value.action
      cidr_block = egress.value.cidr_block

    }
    
  }
 
}
