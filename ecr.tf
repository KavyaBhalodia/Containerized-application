//ecr repository
data "aws_caller_identity" "current" {}


resource "aws_ecr_repository" "images" {
  name                 = "images"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
locals {
  ecr_reg   = "ap-south-1"
  ecr_repo  = "images"
  image_tag = "latest"
}
# resource "null_resource" "docker_packaging" {

#   provisioner "local-exec" {

#     command = "docker build -t ${aws_ecr_repository.images.repository_url}:latest -f Dockerfile ."

#   }

#   provisioner "local-exec" {
#     command = "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-south-1.amazonaws.com"
#   }
#   provisioner "local-exec" {
#     command = "docker push 831794387446.dkr.ecr.ap-south-1.amazonaws.com/images:latest"
#   }
# provisioner "local-exec" {
# 	command = "bash script.sh ${aws_ecr_repository.images.repository_url}"
# }
	
# 	  triggers = {
# 	    "run_at" = timestamp()
# 	  }

#   depends_on = [
#     aws_ecr_repository.images,
#   ]
# }

	
# output "url" {
#   value = aws_ecr_repository.images.repository_url

# }