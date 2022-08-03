/*
data "aws_security_group" "dataExportSG" {
  id = var.data_export_security_group_id
}*/

/*data "aws_lb" "elasticloadbalancer" {
  name = var.load_balancer_name
  provider = aws.
}

data "aws_lb_listener" "listener443" {
  load_balancer_arn = data.aws_lb.elasticloadbalancer.arn
  port              = 443
}

data "aws_lb_listener" "listener80" {
  load_balancer_arn = data.aws_lb.elasticloadbalancer.arn
  port              = 80
}*/

data "aws_iam_role" "ecs_task_execution_role" {
  name = var.iam_role_name["ecs_task_execution_role"]
  provider = aws.target-us-east-1
}

data "aws_iam_role" "ecs_task_role" {
  name = var.iam_role_name["ecs_task_role"]
  provider = aws.target-us-east-1
}

data "aws_iam_role" "codedeploy_role" {
  name = var.iam_role_name["codedeploy"]
  provider = aws.target-us-east-1
}

data "aws_iam_role" "cross_account_role_for_target" {
  name = var.iam_role_name["cross_account_role_for_target"]
  provider = aws.target-us-east-1
}

data "aws_kms_key" "kms_key-us-east-1" {
  key_id = "alias/${var.kms_key_alias_name-us-east-1}"
  provider = aws.tools
}

data "aws_kms_key" "kms_key-ap-southeast-2" {
  key_id = "alias/${var.kms_key_alias_name-ap-southeast-2}"
  provider = aws.tools-ap-southeast-2
}

data "aws_kms_key" "kms_key-eu-central-1" {
  key_id = "alias/${var.kms_key_alias_name-eu-central-1}"
  provider = aws.tools-eu-central-1
}

/* 
data "aws_ecs_task_definition" "task_definition_family_us_east_1" {
  task_definition = "${var.task_names["thread_tokenization"]}-${lookup(var.environment_name,terraform.workspace)}"
  provider = aws.target-us-east-1
}

data "aws_ecs_task_definition" "task_definition_family_eu_central_1" {
  task_definition = "${var.task_names["thread_tokenization"]}-${lookup(var.environment_name,terraform.workspace)}"
  provider = aws.target-us-east-1
}

data "aws_ecs_task_definition" "task_definition_family_ap_southeast_2" {
  task_definition = "${var.task_names["thread_tokenization"]}-${lookup(var.environment_name,terraform.workspace)}"
  provider = aws.target-us-east-1
}
*/