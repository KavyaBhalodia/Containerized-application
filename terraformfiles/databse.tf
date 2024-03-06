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

#dynamo-db table for state-locking
resource "aws_dynamodb_table" "conainerized-application-dynamodb-table" {
  provider       = aws.sandbox
  name           = "containerized-application-tf-lockID"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"
  attribute {
    name = "id"
    type = "S"
  }
  tags = {
    Name = "containerized-application-tf-lockID"
  }
}