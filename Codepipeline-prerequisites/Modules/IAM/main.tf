# ------- IAM Roles and policies for Codedeploy Resources and Cross/Tools Account Access (Target Account)  -------

resource "aws_iam_role" "codedeploy_role" {
  name               = var.name_code_deploy_role
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
      ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "codedeploy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
  role       = aws_iam_role.codedeploy_role.name
}

resource "aws_iam_policy" "policy_for_codedeploy_role" {
  name        = "Policy-${var.name_code_deploy_role}"
  description = "IAM Policy for Role ${var.name_code_deploy_role}"
  policy      = data.aws_iam_policy_document.policy_codedeploy_role.json

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "codedeploy_role_attachment" {
  policy_arn = aws_iam_policy.policy_for_codedeploy_role.arn
  role       = aws_iam_role.codedeploy_role.name

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "policy_codedeploy_role" {
   statement {
       effect =  "Allow"
       actions= [
         "s3:Get*"
       ]
       resources= [
         "arn:aws:s3:::${var.bucket_names[0]}/*",
         "arn:aws:s3:::${var.bucket_names[1]}/*",
         "arn:aws:s3:::${var.bucket_names[2]}/*"
       ]
     }
   statement {
       effect =  "Allow"
       actions= [
         "s3:ListBucket"
       ]
       resources= [
         "arn:aws:s3:::${var.bucket_names[0]}",
         "arn:aws:s3:::${var.bucket_names[1]}",
         "arn:aws:s3:::${var.bucket_names[2]}",
       ]
     }
   statement {
       effect = "Allow"
       actions= [
           "kms:DescribeKey",
           "kms:GenerateDataKey*",
           "kms:Encrypt",
           "kms:ReEncrypt*",
           "kms:Decrypt"
          ]
       resources= [
           //"arn:aws:kms:${var.aws_region_toolsacc}:${var.accounts["tools"]}:key/${var.kms_key_arn}"
           var.kms_key_arn[0],
           var.kms_key_arn[1],
           var.kms_key_arn[2],
          ]
      }
}
resource "aws_iam_role" "cross_account_role_for_target" {
  name               = var.name_cross_account_role
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.tools_account_id}:root"
            },
            "Action": "sts:AssumeRole",
            "Condition": {}
        }
    ]
}
EOF
  tags = {
    Name = var.name_cross_account_role
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_policy" "policy_for_cross_account_role_target" {
  name        = "Policy-${var.name_cross_account_role}"
  description = "IAM Policy for Role ${var.name_cross_account_role}"
  policy      = data.aws_iam_policy_document.policy_cross_account_target_role.json

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "cross_account_role_policy_attachment" {
  policy_arn = aws_iam_policy.policy_for_cross_account_role_target.arn
  role       = aws_iam_role.cross_account_role_for_target.name

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "policy_cross_account_target_role" {
   statement {
       effect = "Allow"
       actions= [
                "s3:Get*",
                "s3:List*",
                "s3-object-lambda:Get*",
                "s3-object-lambda:List*"
            ]
       resources=  ["*"]
        }
   statement {
       effect = "Allow"
       actions= [
                "codedeploy:CreateDeployment",
                "codedeploy:GetDeployment",
                "codedeploy:GetDeploymentConfig",
                "codedeploy:GetApplicationRevision",
                "codedeploy:RegisterApplicationRevision",
                "codedeploy:GetApplication"
            ]
       resources=  ["*"]
        }
   statement {
       effect = "Allow"
       actions= [
                "s3:GetObject*",
                "s3:PutObject",
                "s3:PutObjectAcl"
            ]
       resources=  [
                "arn:aws:s3:::${var.bucket_names[0]}/*",
                "arn:aws:s3:::${var.bucket_names[1]}/*",
                "arn:aws:s3:::${var.bucket_names[2]}/*"
            ]
        }
   statement { //Edit before
       effect = "Allow"
       actions= [
                "kms:*"
            ]
       resources=  ["*"]
        }    
   statement {
       effect = "Allow"
       actions= [
                "ecs:RegisterTaskDefinition",
                "ecs:ListTaskDefinitions",
                "ecs:DescribeTaskDefinition"
            ]
       resources=  [
                "*"
            ]
        }   
   statement{
       effect ="Allow"
       actions=  [
                "iam:GetRole",
                "iam:PassRole"
            ]
       resources= [
                "arn:aws:iam::${var.target_account_id}:role/${var.name_ecs_task_role}",
                "arn:aws:iam::${var.target_account_id}:role/${var.name_ecs_task_execution_role}"
            ]
        }
}
