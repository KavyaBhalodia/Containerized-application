#Makefile
GIT_COMMIT_ID=$(shell git rev-parse --short HEAD)
region=ap-south-1
repository_url=$(shell cd terraformfiles && terraform output repository_url)

init plan:
	@cd terraformfiles && terraform $@ 
apply:
	@cd terraformfiles && terraform $@ -auto-approve

ecr_push: login build tag push
login:
	@echo Logging in ECR Repository
	@aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin $(repository_url)
build:
	@echo Building Docker image
	@docker build -t containerized-application code/
tag:
	@echo Tagging Docker image
	@docker tag containerized-application $(repository_url)
	@docker tag containerized-application $(repository_url):$(GIT_COMMIT_ID)
push:
	@echo Pushing Docker image into ECR Repository
	@docker push $(repository_url)
	@docker push $(repository_url):$(GIT_COMMIT_ID)
  
    
    


    
    


	