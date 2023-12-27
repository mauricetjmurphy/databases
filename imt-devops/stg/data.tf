
data "aws_security_group" "nbcu" {
  vpc_id = var.vpc
  tags = {
    Name = "GVS Default Security Group"
  }
}
data "aws_ssm_parameter" "github-token" {
  name = "github-token"
}
