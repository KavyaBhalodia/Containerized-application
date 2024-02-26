resource "aws_db_instance" "default" {
  provider            = aws.sandbox
  allocated_storage   = 20
  db_name             = "kavyaDB"
  identifier          = "kavya-database"
  engine              = "postgres"
  engine_version      = "16.1"
  instance_class      = "db.t3.micro"
  username            = "postgres"
  password            = "kavyabhalodia"
  skip_final_snapshot = true
  storage_type        = "gp2"

}