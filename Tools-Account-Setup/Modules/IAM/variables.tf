# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "name_codepipeline_role" {
  description = "The name for the Codepipeline Role"
  type        = string
  default     = null
}

variable "name_cross_account_role" {
  description = "The name for the Cross Account Role which will give tools account the access to perform operations"
  type        = string
  default     = null
}

variable "target_account_id" {
  description = "Target account ID"
  type        = string
  default     = null  
}

variable "ecr_repositories" {
  description = "The ECR repositories to which grant IAM access"
  type        = list(string)
  default     = ["*"]
}

variable "code_build_projects" {
  description = "The Code Build projects to which grant IAM access"
  type        = list(string)
  default     = ["*"]
}

variable "code_deploy_resources" {
  description = "The Code Deploy applications and deployment groups to which grant IAM access"
  type        = list(string)
  default     = ["*"]
}

