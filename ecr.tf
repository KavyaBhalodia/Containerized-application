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

    command = "bash script.sh ${aws_ecr_repository.images.repository_url}"

  }

	  triggers = {
	    "run_at" = timestamp()
	  }

  depends_on = [
    aws_ecr_repository.images,
  ]
}
