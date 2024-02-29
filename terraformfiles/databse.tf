#RDS postgres database for form
resource "aws_db_instance" "default" {
  provider               = aws.sandbox
  allocated_storage      = 20
  db_name                = "postgres"
  identifier             = "kavya-database"
  engine                 = "postgres"
  engine_version         = "16.1"
  instance_class         = "db.t3.micro"
  username               = "postgres"
  password               = "kavyabhalodia"
  skip_final_snapshot    = true
  storage_type           = "gp2"
  db_subnet_group_name   = aws_db_subnet_group.subnet-grp.name
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  availability_zone      = "us-west-2a"
}

#subnet-grp for database
resource "aws_db_subnet_group" "subnet-grp" {
  name       = "main-grp"
  subnet_ids = aws_subnet.private-subnet.*.id
  provider   = aws.sandbox
}