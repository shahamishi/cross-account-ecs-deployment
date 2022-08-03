variable "aws_region_target" {
  description = "The AWS Region in which you want to deploy the resources"
  type        = string
  default     = "us-east-1"
}

variable "environment_name" {
  description = "The name of your environment"
  type        = map(string)
}

variable "state_purpose" {
  description = "The content that terraform state is created for"
  type = string
  default = "target"
}