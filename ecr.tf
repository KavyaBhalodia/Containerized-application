//ecr repository
data "aws_caller_identity" "current" {}


resource "aws_ecr_repository" "images" {
  name                 = "images"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "docker_packaging" {
provisioner "local-exec" {
  command = <<EOT
    docker build -t "${aws_ecr_repository.images.repository_url}:${chomp("git rev-parse HEAD")}" .
    aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-south-1.amazonaws.com
	  docker push "${aws_ecr_repository.images.repository_url}:${chomp("git rev-parse HEAD")}"
      
  EOT

  interpreter = ["PowerShell", "-Command"]
}
	  triggers = {
	    "run_at" = timestamp()
	  }

  depends_on = [
    aws_ecr_repository.images,
  ]
}

