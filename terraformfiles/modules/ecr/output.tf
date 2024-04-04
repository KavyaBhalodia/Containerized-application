output "image_url" {
  value = aws_ecr_repository.containerized_application_repository.repository_url
}
