/*
data "aws_security_group" "dataExportSG" {
  id = var.data_export_security_group_id
}*/

data "aws_lb" "elasticloadbalancer" {
  name = var.load_balancer_name
}

data "aws_lb_listener" "listener443" {
  load_balancer_arn = data.aws_lb.elasticloadbalancer.arn
  port              = 443
}

data "aws_lb_listener" "listener80" {
  load_balancer_arn = data.aws_lb.elasticloadbalancer.arn
  port              = 80
}
data "aws_iam_role" "ecs_task_execution_role" {
  name = var.iam_role_name["ecs_task_execution_role"]
}

data "aws_iam_role" "ecs_task_role" {
  name = var.iam_role_name["ecs_task_role"]
}

data "aws_iam_role" "codedeploy_role" {
  name = var.iam_role_name["codedeploy"]
}

/*data "aws_kms_key" "kms_key" {
  key_id = "alias/${var.kms_key_alias_name}"
}*/

