data "aws_iam_role" "ecs_task_execution_role" {
  name = var.iam_role_name["ecs_task_execution_role"]
  provider = aws.target
  
}

data "aws_iam_role" "ecs_task_role" {
  name = var.iam_role_name["ecs_task_role"]
  provider = aws.target
  
}
