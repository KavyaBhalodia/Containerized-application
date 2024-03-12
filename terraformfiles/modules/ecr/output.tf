output "image-url" {
  value = aws_ecr_repository.containerized-application-repository.repository_url
}
output "region" {
  value = var.region
}