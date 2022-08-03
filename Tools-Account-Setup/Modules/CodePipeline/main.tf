# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*=======================================================
      AWS CodePipeline for build and deployment
========================================================*/

resource "aws_codestarconnections_connection" "aws_codestar_connection" {
  name          = "Codestar-connection"
  provider_type = "Bitbucket"
}

/*
resource "aws_codepipeline" "aws_codepipeline" {
  count    = var.create_separate_pipeline == false ? 1 : 0
  name     = var.name
  role_arn = var.pipe_role

  artifact_store {
    location = var.s3_bucket
    type     = "S3"
    encryption_key {
      id   = var.kms_key_arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.aws_codestar_connection.arn
        //ConnectionArn    = "arn:aws:codestar-connections:us-east-1:230169046312:connection/2c55a7aa-df9e-4981-bb14-6106d474602a"
        FullRepositoryId = "${var.repo_owner}/${var.repo_name}"
        BranchName       = var.branch
        
      }
    }
  }
  
  stage {
    name = "Build"

    action {
      name             = "Build_thread_data_export"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact_thread_data_export"]

      configuration = {
        ProjectName = var.codebuild_project_thread_data_export
      }
    }

    action {
      name             = "Build_thread_participant_management"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact_thread_participant_management"]

      configuration = {
        ProjectName = var.codebuild_project_thread_participant_management
      }
    }

    action {
      name             = "Build_thread_study_response"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact_thread_study_response"]

      configuration = {
        ProjectName = var.codebuild_project_thread_study_response
      }
    }

    action {
      name             = "Build_thread_study_configurator"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact_thread_study_configurator"]

      configuration = {
        ProjectName = var.codebuild_project_thread_study_configurator
      }
    }

    action {
      name             = "Build_thread_survey_builder"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact_thread_survey_builder"]

      configuration = {
        ProjectName = var.codebuild_project_thread_survey_builder
      }
    }
    

    action {
      name             = "Build_thread_tokenization"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact_thread_tokenization"]

      configuration = {
        ProjectName = var.codebuild_project_thread_tokenization
      }
    }
    
    action {
      name             = "Build_thread_queue_builder"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact_thread_queue_builder"]

      configuration = {
        ProjectName = var.codebuild_project_thread_queue_builder
      }
    }   
    
    
    action {
      name             = "Build_mobileanalytics"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact_mobileanalytics"]

      configuration = {
        ProjectName = var.codebuild_project_mobileanalytics
      }
    }      
    
  }
  
  
  stage {
    name = "Deploy"

    action {
      name            = "Deploy_thread_data_export"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact_thread_data_export"]
      version         = "1"

      configuration = {
        ApplicationName                = var.app_name_thread_data_export
        DeploymentGroupName            = var.deployment_group_thread_data_export
        TaskDefinitionTemplateArtifact = "BuildArtifact_thread_data_export"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "BuildArtifact_thread_data_export"
        AppSpecTemplatePath            = "appspec.yaml"
      }

      role_arn = var.crossaccount_role
    }

    action {
      name            = "Deploy_thread_participant_management"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact_thread_participant_management"]
      version         = "1"

      configuration = {
        ApplicationName                = var.app_name_thread_participant_management
        DeploymentGroupName            = var.deployment_group_thread_participant_management
        TaskDefinitionTemplateArtifact = "BuildArtifact_thread_participant_management"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "BuildArtifact_thread_participant_management"
        AppSpecTemplatePath            = "appspec.yaml"
      }

      role_arn = var.crossaccount_role
    }

    action {
      name            = "Deploy_thread_study_response"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact_thread_study_response"]
      version         = "1"

      configuration = {
        ApplicationName                = var.app_name_thread_study_response
        DeploymentGroupName            = var.deployment_group_thread_study_response
        TaskDefinitionTemplateArtifact = "BuildArtifact_thread_study_response"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "BuildArtifact_thread_study_response"
        AppSpecTemplatePath            = "appspec.yaml"
      }

      role_arn = var.crossaccount_role
    }

    action {
      name            = "Deploy_thread_study_configurator"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact_thread_study_configurator"]
      version         = "1"

      configuration = {
        ApplicationName                = var.app_name_thread_study_configurator
        DeploymentGroupName            = var.deployment_group_thread_study_configurator
        TaskDefinitionTemplateArtifact = "BuildArtifact_thread_study_configurator"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "BuildArtifact_thread_study_configurator"
        AppSpecTemplatePath            = "appspec.yaml"
      }

      role_arn = var.crossaccount_role
    }

    action {
      name            = "Deploy_thread_survey_builder"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact_thread_survey_builder"]
      version         = "1"

      configuration = {
        ApplicationName                = var.app_name_thread_survey_builder
        DeploymentGroupName            = var.deployment_group_thread_survey_builder
        TaskDefinitionTemplateArtifact = "BuildArtifact_thread_survey_builder"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "BuildArtifact_thread_survey_builder"
        AppSpecTemplatePath            = "appspec.yaml"
      }

      role_arn = var.crossaccount_role
    }
    
    action {
      name            = "Deploy_thread_tokenization"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact_thread_tokenization"]
      version         = "1"

      configuration = {
        ApplicationName                = var.app_name_thread_tokenization
        DeploymentGroupName            = var.deployment_group_thread_tokenization
        TaskDefinitionTemplateArtifact = "BuildArtifact_thread_tokenization"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "BuildArtifact_thread_tokenization"
        AppSpecTemplatePath            = "appspec.yaml"
      }

      role_arn = var.crossaccount_role
    }    
    
    action {
      name            = "Deploy_thread_queue_builder"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact_thread_queue_builder"]
      version         = "1"

      configuration = {
        ApplicationName                = var.app_name_thread_queue_builder
        DeploymentGroupName            = var.deployment_group_thread_queue_builder
        TaskDefinitionTemplateArtifact = "BuildArtifact_thread_queue_builder"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "BuildArtifact_thread_queue_builder"
        AppSpecTemplatePath            = "appspec.yaml"
      }

      role_arn = var.crossaccount_role
    }   
    
    action {
      name            = "Deploy_mobileanalytics"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact_mobileanalytics"]
      version         = "1"

      configuration = {
        ApplicationName                = var.app_name_mobileanalytics
        DeploymentGroupName            = var.deployment_group_mobileanalytics
        TaskDefinitionTemplateArtifact = "BuildArtifact_mobileanalytics"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "BuildArtifact_mobileanalytics"
        AppSpecTemplatePath            = "appspec.yaml"
      }

      role_arn = var.crossaccount_role
    }  
    
  }
  
  lifecycle {
    # prevents github OAuthToken from causing updates, since it's removed from state file
    ignore_changes = [stage[0].action[0].configuration]
  }

}



resource "aws_codepipeline" "aws_codepipeline_thread_electronic_data_capture" {
  count    = var.create_separate_pipeline == true ? 1 : 0
  name     = var.name
  role_arn = var.pipe_role

  artifact_store {
    location = var.s3_bucket
    type     = "S3"
    encryption_key {
      id   = var.kms_key_arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact_thread_electronic_data_capture"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.aws_codestar_connection.arn
        //ConnectionArn    = "arn:aws:codestar-connections:us-east-1:230169046312:connection/2c55a7aa-df9e-4981-bb14-6106d474602a"
        FullRepositoryId = "${var.repo_owner}/${var.repo_name}"
        BranchName       = var.branch
        
      }
    }
  }
  
  stage {
    name = "Build"

    action {
      name             = "Build_thread_electronic_data_capture"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact_thread_electronic_data_capture"]
      output_artifacts = ["BuildArtifact_thread_electronic_data_capture"]

      configuration = {
        ProjectName = var.codebuild_project_thread_electronic_data_capture
      }
    }
  }
  
  
  stage {
    name = "Deploy"

    action {
      name            = "Deploy_thread_electronic_data_capture"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact_thread_electronic_data_capture"]
      version         = "1"

      configuration = {
        ApplicationName                = var.app_name_thread_electronic_data_capture
        DeploymentGroupName            = var.deployment_group_thread_electronic_data_capture
        TaskDefinitionTemplateArtifact = "BuildArtifact_thread_electronic_data_capture"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "BuildArtifact_thread_electronic_data_capture"
        AppSpecTemplatePath            = "appspec.yaml"
      }

      role_arn = var.crossaccount_role
    }
  }
  
  lifecycle {
    # prevents github OAuthToken from causing updates, since it's removed from state file
    ignore_changes = [stage[0].action[0].configuration]
  }

}
*/

resource "aws_codepipeline" "aws_codepipeline" {
  //count    = var.create_separate_pipeline == true ? 1 : 0
  name     = var.name
  role_arn = var.pipe_role

/*artifact_stores{
  
    "us-east-1" = {
      location = var.s3_bucket
      type     = "S3"
      encryption_key {
        id   = var.kms_key_arn
        type = "KMS"
      }
      },
      "ap-southeast-2" = {
      location = var.s3_bucket
      type     = "S3"
      encryption_key {
        id   = var.kms_key_arn
        type = "KMS"
      }
      },
      "eu-central-1" = {
      location = var.s3_bucket
      type     = "S3"
      encryption_key {
        id   = var.kms_key_arn
        type = "KMS"
      }
      }
}*/

    /*artifact_store {
      location = var.s3_bucket
      type     = "S3"
      encryption_key {
        id   = var.kms_key_arn
        type = "KMS"
      }
      region = "us-east-1"
    }*/
    
    artifact_store {
      location = var.s3_bucket-us-east-1
      type     = "S3"
      encryption_key {
        id   = var.kms_key_arn-us-east-1
        type = "KMS"
      }
      region = "us-east-1"
    }
    
    artifact_store {
      location = var.s3_bucket-ap-southeast-2
      type     = "S3"
      encryption_key {
        id   = var.kms_key_arn-ap-southeast-2
        type = "KMS"
      }
      region = "ap-southeast-2"
    }    

    artifact_store {
      location = var.s3_bucket-eu-central-1
      type     = "S3"
      encryption_key {
        id   = var.kms_key_arn-eu-central-1
        type = "KMS"
      }
      region = "eu-central-1"
    }
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.aws_codestar_connection.arn
        FullRepositoryId = "${var.repo_owner}/${var.repo_name}"
        BranchName       = var.branch
        
      }
    }
  }
  
  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]

      configuration = {
        ProjectName = var.codebuild_project
      }
    }
  }
  
  
  stage {
    name = "Deploy"

    action {
      name            = "Deploy-us-east-1"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact"]
      version         = "1"
      region          = "us-east-1"

      configuration = {
        ApplicationName                = var.app_name-us-east-1
        DeploymentGroupName            = var.deployment_group-us-east-1
        TaskDefinitionTemplateArtifact = "BuildArtifact"
        TaskDefinitionTemplatePath     = "taskdef-us-east-1.json"
        AppSpecTemplateArtifact        = "BuildArtifact"
        AppSpecTemplatePath            = "appspec-us-east-1.yaml"
      }

      role_arn = var.crossaccount_role
    }
    
    action {
      name            = "Deploy-ap-southeast-2"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact"]
      version         = "1"
      region          = "ap-southeast-2"

      configuration = {
        ApplicationName                = var.app_name-ap-southeast-2
        DeploymentGroupName            = var.deployment_group-ap-southeast-2
        TaskDefinitionTemplateArtifact = "BuildArtifact"
        TaskDefinitionTemplatePath     = "taskdef-ap-southeast-2.json"
        AppSpecTemplateArtifact        = "BuildArtifact"
        AppSpecTemplatePath            = "appspec-ap-southeast-2.yaml"
      }

      role_arn = var.crossaccount_role
    }
    
    action {
      name            = "Deploy-eu-central-1"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact"]
      version         = "1"
      region          = "eu-central-1"

      configuration = {
        ApplicationName                = var.app_name-eu-central-1
        DeploymentGroupName            = var.deployment_group-eu-central-1
        TaskDefinitionTemplateArtifact = "BuildArtifact"
        TaskDefinitionTemplatePath     = "taskdef-eu-central-1.json"
        AppSpecTemplateArtifact        = "BuildArtifact"
        AppSpecTemplatePath            = "appspec-eu-central-1.yaml"
      }

      role_arn = var.crossaccount_role
    }    
  }
  
  lifecycle {
    # prevents github OAuthToken from causing updates, since it's removed from state file
    ignore_changes = [stage[0].action[0].configuration]
  }

}