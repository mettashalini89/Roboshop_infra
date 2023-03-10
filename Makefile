git:
	git pull

dev-apply:	git
	terraform init -backend-config=env-dev/state.tfvars
	terraform apply -auto-approve -var-file=env-dev/main.tfvars

dev-destroy:
	terraform destroy -auto-approve -var-file=env-dev/main.tfvars