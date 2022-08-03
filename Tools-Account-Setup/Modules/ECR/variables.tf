# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "name" {
  description = "The name of your ECR repository"
  type        = string
}

variable "ecs_execution_task_role_arn" {
  description = "The name of your ECS execution task role"
  type        = string
}
