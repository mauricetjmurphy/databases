
format:
	terraform fmt -recursive

deploy-codebuild-dev:
	@echo "**************************codebuild started*****************************"
	cd "dev" && terraform init && terraform apply --auto-approve
	@echo "**************************codebuild completed*****************************"

deploy-dev: format deploy-codebuild-dev
# ************************************************************************************

deploy-codebuild-stg:
	@echo "**************************codebuild started*****************************"
	cd "stg" && terraform init && terraform apply --auto-approve
	@echo "**************************codebuild completed*****************************"
	
deploy-stg: format deploy-codebuild-stg

# ************************************************************************************
deploy-codebuild-prod:
	@echo "**************************codebuild started*****************************"
	cd "prod" && terraform init && terraform apply --auto-approve
	@echo "**************************codebuild completed*****************************"
	
deploy-prod: format deploy-codebuild-prod

# ************************************************************************************
