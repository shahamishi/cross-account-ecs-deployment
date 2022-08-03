# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "name" {
  type        = string
  description = "CodeBuild Project name"
}

variable "iam_role" {
  type        = string
  description = "IAM role to attach to CodeBuild"
}
variable "region" {
  type        = string
  description = "AWS Region used"
}
variable "account_id" {
  description = "AWS Account ID where the ECR repo is"
  type        = string
}

variable "target_account_id" {
  description = "AWS Account ID where the solution is being deployed"
  type        = string
}

/*
variable "CODEBUILD_RESOLVED_SOURCE_VERSION" {
  description = "The commit ID from the source"
  type        = string  
}
*/
variable "ecr_repo_url-us-east-1" {
  description = "AWS ECR repository URL where docker images are being stored"
  type        = string
}

variable "ecr_repo_url-ap-southeast-2" {
  description = "AWS ECR repository URL where docker images are being stored"
  type        = string
}

variable "ecr_repo_url-eu-central-1" {
  description = "AWS ECR repository URL where docker images are being stored"
  type        = string
}

variable "folder_path" {
  description = "Folder path to use to build the docker images/containers"
  type        = string
}

variable "buildspec_path" {
  description = "Path to for the Buildspec file"
  type        = string
}

variable "task_definition_family-us-east-1" {
  description = "The family name of the Task definition"
  type        = string
}

variable "task_definition_family-ap-southeast-2" {
  description = "The family name of the Task definition"
  type        = string
}

variable "task_definition_family-eu-central-1" {
  description = "The family name of the Task definition"
  type        = string
}
variable "container_name" {
  description = "The name of the Container specified in the Task definition"
  type        = string
}

variable "service_port" {
  description = "The number of the port used by the ECS Service"
  type        = number
}

variable "ecs_role" {
  description = "The name of the ECS Task Excecution role to specify in the Task Definition"
  type        = string
}

variable "ecs_task_role" {
  description = "The name of the ECS Task role to specify in the Task Definition"
  type        = string
  default     = "null"
}

variable "datadog_api_key" {
  description = "Registered datadog api key"
  type        = string
  default     = ""
}

variable "microservice_name" {
  description = "The name of the microservice"
  type        = string
  default     = ""
}