vpc                           = "vpc-0847d356950005423"
private_subnets               = ["subnet-05c87c8ceb8fbbcf5", "subnet-06f53a199db159e43", "subnet-0709c4b6b555f1720"]
environment                   = "prod"
tags                          = { name = "env", value = "prod" }
git_branch                    = "master"
build_notification_lambda_arn = "arn:aws:lambda:us-east-1:554993832671:function:teams-buildnotifications-function-prod"