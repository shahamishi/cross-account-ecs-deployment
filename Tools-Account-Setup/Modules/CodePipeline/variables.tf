# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "name" {
  description = "The CodePipeline pipeline name"
  type        = string
}

variable "pipe_role" {
  description = "The role assumed by CodePipeline"
  type        = string
}

variable "s3_bucket-us-east-1" {
  description = "S3 bucket used for the artifact store"
  type        = string
}

variable "s3_bucket-ap-southeast-2" {
  description = "S3 bucket used for the artifact store"
  type        = string
}

variable "s3_bucket-eu-central-1" {
  description = "S3 bucket used for the artifact store"
  type        = string
}

variable "repo_owner" {
  description = "The username of the Github repository owner"
  type        = string
}

variable "repo_name" {
  description = "Github repository's name"
  type        = string
}

variable "branch" {
  description = "Github branch used to trigger the CodePipeline"
  type        = string
}

variable "kms_key_arn-us-east-1" {
  description = "The KMS Key to access the artifact store"
  type        = string
  default = ""
}

variable "kms_key_arn-ap-southeast-2" {
  description = "The KMS Key to access the artifact store"
  type        = string
  default = ""
}

variable "kms_key_arn-eu-central-1" {
  description = "The KMS Key to access the artifact store"
  type        = string
  default = ""
}

variable "crossaccount_role" {
  description = "The cross account role"
  type        = string
  default = "ABC"
}

/*variable "codebuild_project_thread_data_export" {
  description = "thread_data_export's CodeBuild project name"
  type        = string
  default = ""  
}

variable "app_name_thread_data_export" {
  description = "CodeDeploy Application name for the data_export"
  type        = string
  default = ""  
}

variable "deployment_group_thread_data_export" {
  description = "CodeDeploy deployment group name for the data_export"
  type        = string
  default = ""
}

variable "codebuild_project_thread_participant_management" {
  description = "thread_participant_management's CodeBuild project name"
  type        = string
  default = ""  
}

variable "app_name_thread_participant_management" {
  description = "CodeDeploy Application name for the thread_participant_management"
  type        = string
  default = ""  
}

variable "deployment_group_thread_participant_management" {
  description = "CodeDeploy deployment group name for the thread_participant_management"
  type        = string
  default = ""
}


variable "codebuild_project_thread_study_response" {
  description = "thread_study_response's CodeBuild project name"
  type        = string
  default = ""  
}

variable "app_name_thread_study_response" {
  description = "CodeDeploy Application name for the thread_study_response"
  type        = string
  default = ""  
}

variable "deployment_group_thread_study_response" {
  description = "CodeDeploy deployment group name for the thread_study_response"
  type        = string
  default = ""
}


variable "codebuild_project_thread_study_configurator" {
  description = "thread_study_configurator's CodeBuild project name"
  type        = string
  default = ""  
}

variable "app_name_thread_study_configurator" {
  description = "CodeDeploy Application name for the thread_study_configurator"
  type        = string
  default = ""  
}

variable "deployment_group_thread_study_configurator" {
  description = "CodeDeploy deployment group name for the thread_study_configurator"
  type        = string
  default = ""
}


variable "codebuild_project_thread_survey_builder" {
  description = "thread_survey_builder's CodeBuild project name"
  type        = string
  default = ""  
}

variable "app_name_thread_survey_builder" {
  description = "CodeDeploy Application name for the thread_survey_builder"
  type        = string
  default = ""  
}

variable "deployment_group_thread_survey_builder" {
  description = "CodeDeploy deployment group name for the thread_survey_builder"
  type        = string
  default = ""
}

variable "codebuild_project_thread_tokenization" {
  description = "thread_tokenization's CodeBuild project name"
  type        = string
  default = ""  
}

variable "app_name_thread_tokenization" {
  description = "CodeDeploy Application name for the thread_tokenization"
  type        = string
  default = ""  
}

variable "deployment_group_thread_tokenization" {
  description = "CodeDeploy deployment group name for the thread_tokenization"
  type        = string
  default = ""
}

variable "codebuild_project_thread_queue_builder" {
  description = "thread_queue_builder's CodeBuild project name"
  type        = string
  default = ""  
}

variable "app_name_thread_queue_builder" {
  description = "CodeDeploy Application name for the thread_queue_builder"
  type        = string
  default = ""  
}

variable "deployment_group_thread_queue_builder" {
  description = "CodeDeploy deployment group name for the thread_queue_builder"
  type        = string
  default = ""
}

variable "codebuild_project_mobileanalytics" {
  description = "mobileanalytics's CodeBuild project name"
  type        = string
  default = ""  
}

variable "app_name_mobileanalytics" {
  description = "CodeDeploy Application name for the mobileanalytics"
  type        = string
  default = ""  
}

variable "deployment_group_mobileanalytics" {
  description = "CodeDeploy deployment group name for the mobileanalytics"
  type        = string
  default = ""
}

variable "create_separate_pipeline" {
  type = bool
  default = false
}


variable "codebuild_project_thread_electronic_data_capture" {
  description = "thread_electronic_data_capture's CodeBuild project name"
  type        = string
  default = ""  
}

variable "app_name_thread_electronic_data_capture" {
  description = "CodeDeploy Application name for the thread_electronic_data_capture"
  type        = string
  default = ""  
}

variable "deployment_group_thread_electronic_data_capture" {
  description = "CodeDeploy deployment group name for the thread_electronic_data_capture"
  type        = string
  default = ""
}*/

variable "codebuild_project" {
  description = "CodeBuild project name"
  type        = string
  default = ""  
}

variable "app_name-us-east-1" {
  description = "CodeDeploy Application name for us-east-1"
  type        = string
  default = ""  
}

variable "deployment_group-us-east-1" {
  description = "CodeDeploy deployment group name for us-east-1"
  type        = string
  default = ""
}

variable "app_name-ap-southeast-2" {
  description = "CodeDeploy Application name for ap-southeast-2"
  type        = string
  default = ""  
}

variable "deployment_group-ap-southeast-2" {
  description = "CodeDeploy deployment group name for ap-southeast-2"
  type        = string
  default = ""
}

variable "app_name-eu-central-1" {
  description = "CodeDeploy Application name for eu-central-1"
  type        = string
  default = ""  
}

variable "deployment_group-eu-central-1" {
  description = "CodeDeploy deployment group name for eu-central-1"
  type        = string
  default = ""
}