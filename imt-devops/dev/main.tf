provider "aws" {
  profile = "awsgvsdev"
  region  = var.aws-region
}


terraform {
  backend "s3" {
    bucket  = "gvs-remotestate-backend-s3-dev"
    key     = "buildpipeline-rds-dev.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "awsgvsdev"

  }
}

# ************************************************************************************************************************************

variable "aws-region" {
  type    = string
  default = "us-east-1"
}


variable "environment" {
  type        = string
  description = "Must Be Lower Case!"
}

variable "private_subnets" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "vpc" {
  type = string
}

variable "git_branch" {
  type = string
}



# ************************************************************************************************************************************
module "template" {
  source = "git::https://github.com/mauricetjmurphy/terraform-modules.git//buildspec"
}

data "template_file" "buildspec" {
  template = module.template.source
  vars = {
    build_env    = "development"
    make_command = "make migrate-dev"
  }
}


data "aws_security_group" "nbcu" {
  vpc_id = var.vpc
  tags = {
    Name = "GVS Default Security Group"
  }
}

data "aws_ssm_parameter" "github-token" {
  name = "github-token"
}


# ************************************************************************************************************************************
module "codepipeline_imt-databases" {
  environment               = var.environment
  source                    = "git::https://github.com/mauricetjmurphy/terraform-modules.git//codepipeline"
  git_token                 = data.aws_ssm_parameter.github-token.value
  git_organization          = "mauricetjmurphy"
  git_domain                = "https://github.com"
  git_repository_name       = "imt-databases"
  git_branch                = var.git_branch
  git_application_name      = "gvs-rds"
  git_buildspec_file        = data.template_file.buildspec.rendered
  vpc                       = var.vpc
  codebuild_private_subnets = var.private_subnets
  security_group            = data.aws_security_group.nbcu.id
  tags                      = var.tags
}
# ************************************************************************************************************************************
