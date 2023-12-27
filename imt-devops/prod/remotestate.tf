provider "aws" {
  profile = "awsgvsprod"
  region  = var.aws-region
}


terraform {
  backend "s3" {
    bucket  = "gvs-remotestate-backend-s3-prod"
    key     = "buildpipeline-rds-prod.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "awsgvsprod"

  }
}