
#### AWS Account related variables 
variable "accounts" {
  type = map
}

variable "environment_name" {
  description = "The name of your environment"
  type        = map(string)
}

variable "aws_profile_tools" {
  description = "The profile name in which you want to deploy the pipeline"
  type        = string
  default     = "tools_account"
}

variable "aws_region_tools" {
  description = "The AWS Region in which you want to deploy the pipeline resources"
  type        = string
  default     = "us-east-1"
}

variable "target_account_regions" {
  description = "Target account regions where the microservices are going to be deployed"
  type = map(string)
  default = {
  "us-east-1" = "us-east-1"
  "ap-southeast-2" = "ap-southeast-2"
  "eu-central-1" = "eu-central-1"
  }
}

variable "iam_role_name" {
  description = "The name of the IAM Role for each service"
  type        = map(string)
}

variable "kms_key_alias_name-us-east-1" {
  description = "KMS Key alias name"
  type = string
}

variable "kms_key_alias_name-ap-southeast-2" {
  description = "KMS Key alias name"
  type = string
}

variable "kms_key_alias_name-eu-central-1" {
  description = "KMS Key alias name"
  type = string
}

variable "aws_profile_target" {
  description = "The profile name that you have configured in the file .aws/credentials"
  type        = string
}

variable "aws_region_target" {
  description = "The AWS Region in which you want to deploy the resources"
  type        = string
}

variable "scan_filter" {
    description = "The filter to apply on scanning ECR Repositories"
    type        = string
    default     = "*-automation-*"
}
