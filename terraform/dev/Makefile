help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

update: ## Update all modules 
	terraform get -update

init: ## Initial Terraform, change backends or modules needs initial again.
	terraform init -backend=true

plan: ## Show results about the resources you are going to change.
	terraform plan -var-file=config/dev.tfvars -out plan.out

apply: ## Deploy
	terraform apply plan.out

output: ## Show Outputs
	terraform output