## How to run

Please go into execute directory first.
```bash
cd terraform/${ENV}
```

### Makefile
```makefile
update: ## Update all modules 
	terraform get -update

init: ## Initial Terraform, change backends or modules needs initial again.
	terraform init -backend=true

plan: ## Show results about the resources you are going to change.
	terraform plan -var-file=config/${ENV}.tfvars -out plan.out

apply: ## Deploy
	terraform apply plan.out
```

### Check Result
```bash
make init && make plan
```

### DEPLOY
```bash
make init && make plan && make deploy
```

## Structure

```
terraform
├── dev
│   └── config
└── modules
    └── node_group

```


## Terraform Documents

For MacOS  
```bash
brew install terraform-docs

terraform-docs md . > README.md
```