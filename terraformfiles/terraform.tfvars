public_subnet_cidr  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidr = ["10.0.16.0/24", "10.0.32.0/24"]
az                  = ["us-west-2a", "us-west-2b"]
region              = "us-west-2"
ecr-repository      = "containerized-app-repository"
environment_variable = {
  DB_HOST        = "kavya-database.ckddpdbqvvn5.us-west-2.rds.amazonaws.com"
  DB_PASSWORD    = "kavyabhalodia"
  DB_USER        = "postgres"
  DB_PORT        = "5432"
  SESSION_SECRET = "secret"
}