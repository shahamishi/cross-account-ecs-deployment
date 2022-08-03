
variable "environment_name" {
  description = "The name of your environment"
  type        = map(string)
}

variable "aws_profile_target" {
  description = "The profile name that you have configured in the file .aws/credentials"
  type        = string
}

variable "aws_region_target" {
  description = "The AWS Region in which you want to deploy the resources"
  type        = string
}

variable "tools_account_id" {
  type = number
  default = 230169046312
  
}

#### Networking related information 

variable "vpc_id" {
  description = "The VPC ID in which the the ECS Cluster and target group should be there"
  type = string
}

variable "load_balancer_name"{
  type = string
}

variable "security_group_id" {
    description   = "Security group id for Data Export Microservice"
    type          = string
}

variable "subnet_ids" {
  type    = list(string)
}


variable "cluster_name" {
    description = "The name of the ECS Cluster"
    type        = string
}


variable "container_names" {
  description = "The name of the container for each microservice"
  type        = map(string)
  default = {
    abc = "abc_ms-automation-test"
  }
}

variable "service_names" {
  description = "The name of the service for each microservice"
  type        = map(string)
  default = {
    abc = "abc-service-automation-test"
    }
}

variable "task_names" {
  description = "The name of the task for each microservice"
  type        = map(string)
  default = {
    abc   = "abc-task-automation-test" 
  }
}

variable "container_ports" {
  description = "The container ports for each microservice"
  type        = map(number)
  default = {
    abc   = 8000
  }
}

variable "health_check_paths" {
  description = "The container ports for each microservice"
  type        = map(string)
  default = {
    abc   = "/api/ecs/v1/abc/health"
  }
}

variable "autoscaling_name" {
  description = "The name of the autoscaling group for each microservice"
  type        = map(string)
  default = {
    abc   = "abc_autoscaling_group-automation-test"
  }
}

variable "ecr_repository_names" {
  description = "The ecr repository names for each microservice"
  type        = map(any)
  default = {
    abc   = "abc-automation-test"
  }
}

variable "codedeploy_application_names" {
  description = "The name of the service for each microservice"
  type        = map(string)
  default = {
    abc   = "abc"
    }
}

variable "listerner_rule_condition_path" {
  type        = map(string)
  default = {
    abc   = "/api/ecs/v1/abc/*"
  }

}

variable "iam_role_name" {
  description = "The name of the IAM Role for each service"
  type        = map(string)
}

variable "kms_key_alias_name" {
  type = string
}