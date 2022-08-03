module "ecr-us-east-1" {
  source = "./Modules/ECR"
  name = "${var.ecr_repository_names["abc"]}-${lookup(var.environment_name,terraform.workspace)}"
  ecs_execution_task_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
  providers = {
    "aws" = "aws.tools"
  }  
}


module "ecr-ap-southeast-2" {
  source = "./Modules/ECR"
  name = "${var.ecr_repository_names["abc"]}-${lookup(var.environment_name,terraform.workspace)}"
  ecs_execution_task_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
  providers = {
    "aws" = "aws.tools-ap-southeast-2"
  }  
}


module "ecr-eu-central-1" {
  source = "./Modules/ECR"
  name = "${var.ecr_repository_names["abc"]}-${lookup(var.environment_name,terraform.workspace)}"
  ecs_execution_task_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
  providers = {
    "aws" = "aws.tools-eu-central-1"
  }  
}
