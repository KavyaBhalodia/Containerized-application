output "db-password" {
  value = aws_db_instance.containerized-app-db.password
}
output "db-username" {
  value = aws_db_instance.containerized-app-db.username
}
output "name" {
  value = aws_db_instance.containerized-app-db.db-identifier
}