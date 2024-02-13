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

provisioner "local-exec" {
	command = "bash script.sh ${aws_ecr_repository.images.repository_url}"
}
	
	  triggers = {
	    "run_at" = timestamp()
	  }

  depends_on = [
    aws_ecr_repository.images,
  ]
}

	
output "url" {
  value = aws_ecr_repository.images.repository_url

}