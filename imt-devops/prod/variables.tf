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



