//ecr repository
data "aws_caller_identity" "current" {}


resource "aws_ecr_repository" "images" {
  name                 = "images"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "docker_packaging" {

  provisioner "local-exec" {

    command = "docker build -t hello-world:latest ."

  }
   provisioner "local-exec" {

    command = "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin ${aws_ecr_repository.images.repository_url}"

  }
   provisioner "local-exec" {

    command = "docker tag hello-world:latest ${aws_ecr_repository.images.repository_url}:latest"

  }
  provisioner "local-exec" {

    command = "docker push ${aws_ecr_repository.images.repository_url}:latest"

  }
  
  

	  triggers = {
	    "run_at" = timestamp()
	  }

  depends_on = [
    aws_ecr_repository.images,
  ]
}
