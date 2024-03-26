output "db_password" {
  value = aws_db_instance.containerized_app_db.password
}
output "db_username" {
  value = aws_db_instance.containerized_app_db.username
}
output "name" {
  value = aws_db_instance.containerized_app_db.identifier
}