
module "alb-security-group" {
    source = "./modules/security-group"
    vpc-id = "${module.vpc.vpc-id}"
    alb-sg-name="containerized-app-alb-sg"
    alb-ingress-rule-from-port=0
    alb-ingress-rule-to-port=0
    alb-egress-rule-from-port=0
    alb-egress-rule-to-port=0
    providers = {
      aws=aws.sandbox
    }
}

 module "ecs-security-group" {
    source = "./modules/security-group"
    vpc-id = "${module.vpc.vpc-id}"
    ecs-sg-name="containerized-app-ecs-sg"
    ecs-sg-ingress-rule-from-port=0
    ecs-sg-ingress-rule-to-port=0
    ecs-sg-egress-rule-from-port=0
    ecs-sg-egress-rule-to-port=0
    providers = {
      aws=aws.sandbox
    }
}

module "rds-security-group" {
    source = "./modules/security-group"
    vpc-id = "${module.vpc.vpc-id}"
    rds-sg-name="containerized-app-rds-sg"
    rds-sg-ingress-rule-from-port=0
    rds-sg-ingress-rule-to-port=5432
    rds-sg-egress-rule-from-port=0
    rds-sg-egress-rule-to-port=0
    providers = {
      aws=aws.sandbox
    }
}

module "bastion-host-security-group" {
    source = "./modules/security-group"
    vpc-id = "${module.vpc.vpc-id}"
    bastion-host-sg-name="containerized-app--bastion-host-sg"
    bastion-host-ingress-rule-from-port=0
    bastion-host-ingress-rule-to-port=0
    bastion-host-egress-rule-from-port=0
    bastion-host-egress-rule-to-port=0
  providers = {
    aws = aws.sandbox
  }
}