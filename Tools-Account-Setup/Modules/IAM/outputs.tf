# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*output "ecs_task_excecution_role_arn" {
  value = aws_iam_role.ecs_task_excecution_role.arn
}*/
/*
output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
  
}
*/
output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline_role.arn
}