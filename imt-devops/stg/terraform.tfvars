vpc                           = "vpc-07fbbeae06a10fdf0"
private_subnets               = ["subnet-0a3afe02504226fa4"]
environment                   = "stg"
tags                          = { name = "env", value = "stg" }
git_branch                    = "stg"
build_notification_lambda_arn = "arn:aws:lambda:us-east-1:347910674570:function:teams-buildnotifications-function-dev"