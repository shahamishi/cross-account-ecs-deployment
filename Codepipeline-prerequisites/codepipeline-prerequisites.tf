
# ------- Random numbers intended to be used as unique identifiers for resources -------
resource "random_id" "RANDOM_ID" {
  byte_length = "2"
}

# ------- Creating Bucket to store CodePipeline artifacts -------
module "s3_codepipeline_us-east-1" {
  source      = "./Modules/S3"
  bucket_name = "codepipeline-${var.target_account_regions["us-east-1"]}-${lookup(var.environment_name,terraform.workspace)}-${random_id.RANDOM_ID.hex}"
  target_account_id = var.accounts["target"]
  
  providers = {
    aws = aws.tools-us-east-1
  }  
}

module "s3_codepipeline_ap-southeast-2" {
  source      = "./Modules/S3"
  bucket_name = "codepipeline-${var.target_account_regions["ap-southeast-2"]}-${lookup(var.environment_name,terraform.workspace)}-${random_id.RANDOM_ID.hex}"
  target_account_id = var.accounts["target"]
  
  providers = {
    aws = aws.tools-ap-southeast-2
  }  
}

module "s3_codepipeline_eu-central-1" {
  source      = "./Modules/S3"
  bucket_name = "codepipeline-${var.target_account_regions["eu-central-1"]}-${lookup(var.environment_name,terraform.workspace)}-${random_id.RANDOM_ID.hex}"
  target_account_id = var.accounts["target"]
  
  providers = {
    aws = aws.tools-eu-central-1
  }  
}

module "kms-key" {
  source        = "./Modules/KMS"
  pipeline_role = "arn:aws:iam::${var.accounts["tools"]}:role/${var.iam_role_name["codepipeline"]}"
  target_acc_id = var.accounts["target"]
  alias_name = var.kms_key_alias_name-us-east-1

  providers = {
    aws = aws.tools-us-east-1
  }  
}

module "kms-key-ap-southeast-2" {
  source        = "./Modules/KMS"
  pipeline_role = "arn:aws:iam::${var.accounts["tools"]}:role/${var.iam_role_name["codepipeline"]}"
  target_acc_id = var.accounts["target"]
  alias_name = var.kms_key_alias_name-ap-southeast-2

  providers = {
    aws = aws.tools-ap-southeast-2
  }  
}

module "kms-key-eu-central-1" {
  source        = "./Modules/KMS"
  pipeline_role = "arn:aws:iam::${var.accounts["tools"]}:role/${var.iam_role_name["codepipeline"]}"
  target_acc_id = var.accounts["target"]
  alias_name = var.kms_key_alias_name-eu-central-1

  providers = {
    aws = aws.tools-eu-central-1
  }  
}


module iam_roles{
  source                       = "./Modules/IAM"
  
  name_code_deploy_role        = var.iam_role_name["codedeploy"]
  name_ecs_task_execution_role = var.iam_role_name["ecs_task_execution_role"]
  name_ecs_task_role           = var.iam_role_name["ecs_task_role"]
  name_cross_account_role      = var.iam_role_name["cross_account_role_for_target"]  

  bucket_names                 = [module.s3_codepipeline_us-east-1.s3_bucket_id,module.s3_codepipeline_ap-southeast-2.s3_bucket_id,module.s3_codepipeline_eu-central-1.s3_bucket_id] 
  kms_key_arn                  = [module.kms-key.kms_key_arn,module.kms-key-eu-central-1.kms_key_arn,module.kms-key-ap-southeast-2.kms_key_arn]

  tools_account_id             = var.accounts["tools"]
  target_account_id            = var.accounts["target"]

  providers = {
    aws = aws.target
  } 
  
}