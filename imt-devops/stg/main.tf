module "template" {
  source = "git::https://github.com/NBCUniversal/terraform-modules.git//buildspec"
}

data "template_file" "buildspec" {
  template = module.template.source
  vars = {
    build_env    = "staging"
    make_command = "make migrate-stg"
  }
}

module "codepipeline_imt-databases" {
  environment               = var.environment
  source                    = "git::https://github.com/NBCUniversal/terraform-modules.git//codepipeline"
  git_token                 = data.aws_ssm_parameter.github-token.value
  git_organization          = "NBCUniversal"
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