#Makefile

GIT_COMMIT_ID=$(shell git rev-parse --short HEAD)
# repository_url=$(shell cd terraformfiles && terraform output -raw repository_url)
path=terraformfiles
repository_url=$(shell cd $(path) && terraform output -raw repository_url)

init plan:
	@cd $(path) && terraform $@ 
apply:
	@cd $(path) && terraform apply -auto-approve

ecr_build_push: login build tag push
login:
	@echo -----------------------------Logging in ECR Repository $(repository_url)----------------------------------------
	@aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin $(repository_url)
build:
	@echo ------------------------------Building Docker image------------------------------
	@docker build -t containerized-application code/
tag:
	@echo ------------------------------Tagging Docker image with $(GIT_COMMIT_ID)------------------------------
	@docker tag containerized-application $(repository_url)
	@docker tag containerized-application $(repository_url):$(GIT_COMMIT_ID)
push:
	@echo ------------------------------Pushing Docker image with tag $(GIT_COMMIT_ID) into ECR Repository $(repository_url)------------------------------
	@docker push $(repository_url)
	@docker push $(repository_url):$(GIT_COMMIT_ID)




    


	