#RDS postgres database for form
resource "aws_db_instance" "containerized-app-db" {
  allocated_storage      = 20
  db_name                = "postgres"
  identifier             = var.db-identifier
  engine                 = "postgres"
  engine_version         = "16.1"
  instance_class         = "db.t3.micro"
  username               = var.username
  password               = var.password
  skip_final_snapshot    = true
  storage_type           = "gp2"
  db_subnet_group_name   = aws_db_subnet_group.subnet-grp.name
  vpc_security_group_ids = var.rds-sg
  availability_zone      = "us-west-2a"
}

#subnet-grp for database
resource "aws_db_subnet_group" "subnet-grp" {
  name       = var.subnet-grp-name
  subnet_ids = var.public-subnets
  
}

#dynamo-db table for state-locking
# resource "aws_dynamodb_table" "conainerized-application-dynamodb-table" {
#   provider       = aws.sandbox
#   name           = "containerized-application-tf-lockID"
#   billing_mode   = "PROVISIONED"
#   read_capacity  = 20
#   write_capacity = 20
#   hash_key       = "id"
#   attribute {
#     name = "id"
#     type = "S"
#   }
#   tags = {
#     Name = "containerized-application-tf-lockID"
#   }
# }