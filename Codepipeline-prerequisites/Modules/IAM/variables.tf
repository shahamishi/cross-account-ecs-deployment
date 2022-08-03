# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "name_ecs_task_execution_role" {
  description = "The name for the ecs task execution role"
  type        = string
  default     = null
}

variable "name_ecs_task_role" {
  description = "The name for the Ecs Task Role"
  type        = string
  default     = null
}

variable "name_code_deploy_role" {
  description = "The name for the Code deploy Role"
  type        = string
  default     = null
}

variable "name_cross_account_role" {
  description = "The name for the Cross Account Role which will give tools account the access to perform operations"
  type        = string
  default     = null
}

variable "tools_account_id" {
  description = "Tools account ID"
  type        = string
  default     = null  
}

variable "target_account_id" {
  description = "Target account ID"
  type        = string
  default     = null  
}

variable "bucket_names"{
  description = "The bucket name for the artifact"
  type        = list(string)
  default     = []
}

variable "kms_key_arn"{
  description = "The kms key to access the artifact bucket"
  type        = list(string)
  default     = []
}