# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*===========================================
      AWS IAM for different resources
============================================*/


# ------- IAM Roles and policies for CodePipeline Resources (Tools Account)  -------



resource "aws_iam_role" "codepipeline_role" {
  //count                   = var.create_devops_role == true ? 1 : 0
  name                    = var.name_codepipeline_role
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "codebuild.amazonaws.com",
          "codedeploy.amazonaws.com",
          "codepipeline.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    Name = var.name_codepipeline_role
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_policy" "policy_for_codepipeline_role" {
  provider = aws.tools
  //count       = var.create_devops_policy == true ? 1 : 0
  name        = "Policy-${var.name_codepipeline_role}"
  description = "IAM Policy for Role ${var.name_codepipeline_role}"
  policy      = data.aws_iam_policy_document.policy_codepipeline_role.json

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "codepipeline_role_policy_attachment" {
  provider = aws.tools
  //count      = var.create_devops_policy == true ? 1 : 0
  policy_arn = aws_iam_policy.policy_for_codepipeline_role.arn
  role       = aws_iam_role.codepipeline_role.name

  lifecycle {
    create_before_destroy = true
  }
}

# ------- IAM Policy Documents -------
data "aws_iam_policy_document" "policy_codepipeline_role" {
  provider = aws.tools
  statement {
    sid    = "AllowS3Actions"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:List*"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCodebuildActions"
    effect = "Allow"
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codebuild:BatchGetBuildBatches",
      "codebuild:StartBuildBatch",
      "codebuild:StopBuild"
    ]
    resources = var.code_build_projects
  }
  statement {
    sid    = "AllowCodebuildList"
    effect = "Allow"
    actions = [
      "codebuild:ListBuilds"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCodeDeployActions"
    effect = "Allow"
    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentGroup",
      "codedeploy:RegisterApplicationRevision"
    ]
    resources = var.code_deploy_resources
  }
  statement {
    sid    = "AllowCodeDeployConfigs"
    effect = "Allow"
    actions = [
      "codedeploy:GetDeploymentConfig",
      "codedeploy:CreateDeploymentConfig",
      "codedeploy:CreateDeploymentGroup",
      "codedeploy:GetDeploymentTarget",
      "codedeploy:StopDeployment",
      "codedeploy:ListApplications",
      "codedeploy:ListDeploymentConfigs",
      "codedeploy:ListDeploymentGroups",
      "codedeploy:ListDeployments"

    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowECRActions"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    resources = var.ecr_repositories
  }
  statement {
    sid    = "AllowECRAuthorization"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCECSServiceActions"
    effect = "Allow"
    actions = [
      "ecs:ListServices",
      "ecs:ListTasks",
      "ecs:DescribeServices",
      "ecs:DescribeTasks",
      "ecs:DescribeTaskDefinition",
      "ecs:DescribeTaskSets",
      "ecs:DeleteTaskSet",
      "ecs:DeregisterContainerInstance",
      "ecs:CreateTaskSet",
      "ecs:UpdateCapacityProvider",
      "ecs:PutClusterCapacityProviders",
      "ecs:UpdateServicePrimaryTaskSet",
      "ecs:RegisterTaskDefinition",
      "ecs:RunTask",
      "ecs:StartTask",
      "ecs:StopTask",
      "ecs:UpdateService",
      "ecs:UpdateCluster",
      "ecs:UpdateTaskSet"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowIAMPassRole"
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCloudWatchActions"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCodestarconnection"
    effect = "Allow"
    actions = ["codestar-connections:UseConnection"]
    resources = ["arn:aws:codestar-connections:*"]
    //resources = ["arn:aws:codestar-connections:us-east-1:298973770113:connection/a23d479b-c170-4f48-af9a-a1f47621c70f"]
  }  
  statement {
    sid = "AllowCodePipelineS3"
    effect = "Allow"
    actions = [
              "kms:Encrypt",
              "kms:Decrypt",
              "kms:ReEncrypt*",
              "kms:GenerateDataKey*",
              "kms:DescribeKey"]
    resources = ["*"]
  }
  statement {
       sid = "AllowTarget"
       effect= "Allow"
       actions= ["sts:AssumeRole"]
       resources= [
           "arn:aws:iam::${var.target_account_id}:role/*"
       ]
   }
  statement {
       sid = "AllowCrossAccount"
       effect= "Allow"
       actions= ["sts:AssumeRole"]
       resources= [
           "arn:aws:iam::${var.target_account_id}:role/${var.name_cross_account_role}"
       ]
   }
}