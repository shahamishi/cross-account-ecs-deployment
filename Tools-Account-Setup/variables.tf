
variable "environment_name" {
  description = "The name of your environment"
  type        = map(string)
}

variable "aws_profile_target" {
  description = "The profile name that you have configured in the file .aws/credentials"
  type        = string
}

variable "aws_profile_tools" {
  description = "The profile name that you have configured in the file .aws/credentials"
  type        = string
}

variable "aws_region_tools" {
  description = "The profile name that you have configured in the file .aws/credentials"
  type        = string
  default     = "us-east-1"
}

variable "accounts" {
  type = map
}

/*variable "aws_region_target" {
  description = "The AWS Region in which you want to deploy the resources"
  type        = string
}*/

variable "tools_account_id" {
  type = number
  default = 123
  
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

variable "folder_paths" {
  description = "The docker image's path for each microservice"
  type        = map(string)
  default = {
    abc   = "./abc"
  }
}

variable "buildspec_paths" {
  description = "The buildspec file's path for each microservice"
  type        = map(string)
  default = {
    abc   = "./abc/Infrastructure/buildspec.yaml"
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

variable "scan_filter" {
    description = "The filter to apply on scanning ECR Repositories"
    type        = string
    default     = "*-automation-*"
}



variable "datadog_api_key" {
    description = "The datadog api key"
    type        = string
}

variable "codebuild_project_names" {
  description = "The name of the service for each microservice"
  type        = map(string)
  default = {
    abc   = "abc"
    }
}

variable "codepipeline_names" {
  description = "The name of the codepipeline"
  type        = map(string)
  default = {
    abc = "abc"
  }
}

variable "repository_owner" {
  description = "The name of the owner of the Github repository"
  type        = string
}

variable "repository_names_microservices" {
  type        = map(string)
  description = "The name of the individual microservices repository"
}

variable "repository_branches_microservices" {
  type        = map(string)
  description = "The name of the branch of individual microservices repository"
}

variable "kms_key_alias_name-us-east-1" {
  type = string
}

variable "kms_key_alias_name-ap-southeast-2" {
  type = string
}

variable "kms_key_alias_name-eu-central-1" {
  type = string
}

variable "s3_bucket_id-eu-central-1" {
  type = string
}

variable "s3_bucket_id-us-east-1" {
  type = string
}

variable "s3_bucket_id-ap-southeast-2" {
  type = string
}


