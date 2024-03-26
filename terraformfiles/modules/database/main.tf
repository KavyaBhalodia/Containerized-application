#RDS postgres database for form
resource "aws_db_instance" "containerized_app_db" {
  allocated_storage      = 20
  db_name                = "postgres"
  identifier             = var.db_identifier
  engine                 = "postgres"
  engine_version         = "16.1"
  instance_class         = "db.t3.micro"
  username               = var.username
  password               = var.password
  skip_final_snapshot    = true
  storage_type           = "gp2"
  db_subnet_group_name   = aws_db_subnet_group.subnet_grp.name
  vpc_security_group_ids = var.rds_sg
  availability_zone      = "us-west-2a"
}

#subnet_grp for database
resource "aws_db_subnet_group" "subnet_grp" {
  name       = var.subnet_grp_name
  subnet_ids = var.public_subnets
}

