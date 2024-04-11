init plan:
	@cd terraformfiles && terraform $@ 
apply:
	@cd terraformfiles && terraform $@ -auto-approve