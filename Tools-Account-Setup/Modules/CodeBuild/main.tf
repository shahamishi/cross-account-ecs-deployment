# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*==================================
      AWS CodeBuild Project
===================================*/

resource "aws_codebuild_project" "aws_codebuild" {
  name          = var.name
  description   = "Terraform codebuild project"
  build_timeout = "10"
  service_role  = var.iam_role

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_REGION"
      value = var.region
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.account_id
    }

    environment_variable {
      name  = "TARGET_ACCOUNT_ID"
      value = var.target_account_id
    }
    
    environment_variable {
      name  = "REPO_URL_US_EAST_1"
      value = var.ecr_repo_url-us-east-1
    }

    environment_variable {
      name  = "REPO_URL_AP_SOUTHEAST_2"
      value = var.ecr_repo_url-ap-southeast-2
    }
    
    environment_variable {
      name  = "REPO_URL_EU_CENTRAL_1"
      value = var.ecr_repo_url-eu-central-1
    }
    
    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
    }

    environment_variable {
      name  = "TASK_DEFINITION_FAMILY_US_EAST_1"
      value = var.task_definition_family-us-east-1
    }
    
    environment_variable {
      name  = "TASK_DEFINITION_FAMILY_AP_SOUTHEAST_2"
      value = var.task_definition_family-ap-southeast-2
    }
    
    environment_variable {
      name  = "TASK_DEFINITION_FAMILY_EU_CENTRAL_1"
      value = var.task_definition_family-eu-central-1
    }    

    environment_variable {
      name  = "CONTAINER_NAME"
      value = var.container_name
    }

    environment_variable {
      name  = "SERVICE_PORT"
      value = var.service_port
    }

    environment_variable {
      name  = "FOLDER_PATH"
      value = var.folder_path
    }

    environment_variable {
      name  = "ECS_ROLE"
      value = var.ecs_role
    }

    environment_variable {
      name  = "ECS_TASK_ROLE"
      value = var.ecs_task_role
    }

    environment_variable {
      name  = "API_KEY"
      value = var.datadog_api_key
    }
    
    environment_variable {
      name  = "MICROSERVICE_NAME"
      value = var.microservice_name
    }    
   /* environment_variable {
      name  = "BITBUCKET_COMMIT_ID"
      value = var.CODEBUILD_RESOLVED_SOURCE_VERSION
    }  */
  }
  


  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.buildspec_path
  }
}