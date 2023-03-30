git:
	#git pull
	rm -rf .terraform
dev-apply: git
	cd aws-parameters; terraform init -backend-config=env-dev/state.tfvars
	cd aws-parameters; terraform apply -auto-approve -var-file=env-dev/main.tfvars
	terraform init -backend-config=env-dev/state.tfvars
	terraform apply -auto-approve -var-file=env-dev/main.tfvars

dev-destroy:
	terraform init -backend-config=env-dev/state.tfvars
	terraform destroy -auto-approve -var-file=env-dev/main.tfvars

prod-apply: git
	cd aws-parameters; terraform init -backend-config=env-prod/state.tfvars
	cd aws-parameters; terraform apply -auto-approve -var-file=env-prod/main.tfvars
	terraform init -backend-config=env-prod/state.tfvars
	terraform apply -auto-approve -var-file=env-prod/main.tfvars

prod-destroy:
	terraform init -backend-config=env-prod/state.tfvars
	terraform destroy -auto-approve -var-file=env-prod/main.tfvars
