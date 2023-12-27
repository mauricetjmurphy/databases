provider "aws" {
  profile = "awsgvsdev"
  region  = var.aws-region
}


terraform {
  backend "s3" {
    bucket  = "gvs-remotestate-backend-s3-stg"
    key     = "buildpipeline-rds-stg.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "awsgvsdev"

  }
}