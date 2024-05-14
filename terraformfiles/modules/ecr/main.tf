
#ECR repository 
resource "aws_ecr_repository" "containerized_application_repository" {
  name                 = var.ecr_repository
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}




