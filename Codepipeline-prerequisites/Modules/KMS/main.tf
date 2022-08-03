resource "aws_kms_key" "target-key" {
  policy = data.aws_iam_policy_document.kms-usage.json
  multi_region = true
}

data "aws_iam_policy_document" "kms-usage" {
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"

    actions = [
      "kms:*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    resources = ["*"]
  }

  statement {
    sid    = "Allow use of the key"
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    principals {
      type        = "AWS"
      identifiers = [
        "${var.pipeline_role}",
        "arn:aws:iam::${var.target_acc_id}:root"
        ]
    }

    resources = ["*"]
  }

  statement {
    sid    = "Allow attachment of persistent resources"
    effect = "Allow"

    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]

    principals {
      type        = "AWS"
      identifiers = [
        "${var.pipeline_role}",
        "arn:aws:iam::${var.target_acc_id}:root" 
        ]
    }

    resources = ["*"]

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
  
}


resource "aws_kms_alias" "kmsKeyAlias" {
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.target-key.key_id
}
