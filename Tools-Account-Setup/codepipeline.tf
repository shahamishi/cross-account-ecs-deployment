module "codebuild_project" {
  source                 = "./Modules/CodeBuild"
  name                   = "${var.codebuild_project_names["abc"]}-${lookup(var.environment_name,terraform.workspace)}"
  iam_role               = module.iam_roles.codepipeline_role_arn
  region                 = var.aws_region_tools
  account_id             = var.accounts["tools"]
  target_account_id     = var.accounts["target"]  
  ecr_repo_url-us-east-1           = module.ecr_thread_tokenization-us-east-1.ecr_repository_url
  ecr_repo_url-ap-southeast-2      = module.ecr_thread_tokenization-ap-southeast-2.ecr_repository_url-ap-southeast-2
  ecr_repo_url-eu-central-1        = module.ecr_thread_tokenization-eu-central-1.ecr_repository_url-eu-central-1  
  folder_path            = var.folder_paths["abc"]
  buildspec_path         = var.buildspec_paths["abc"]
  task_definition_family-us-east-1 = "abc-task-automation-test-devuseast" //data.aws_ecs_task_definition.task_definition_family_us_east_1.family
  task_definition_family-ap-southeast-2 = "abc-task-automation-test-devap"  //data.aws_ecs_task_definition.task_definition_family_ap_southeast_2.family 
  task_definition_family-eu-central-1 = "abc-task-automation-test-deveu" //data.aws_ecs_task_definition.task_definition_family_eu_central_1.family
  container_name         = var.container_names["thread_tokenization"]
  service_port           = var.container_ports["thread_tokenization"]
  ecs_role               = var.iam_role_name["ecs_task_execution_role"]
  ecs_task_role          = var.iam_role_name["ecs_task_role"]
  datadog_api_key        = var.datadog_api_key
  microservice_name      = "abc-ecs-${lookup(var.environment_name,terraform.workspace)}"
  providers = {
    "aws" = "aws.tools"
  }  
}

module "codepipeline_thread_tokenization" {
  source                   = "./Modules/CodePipeline"
  name                     = "${var.codepipeline_names["abc"]}-${lookup(var.environment_name,terraform.workspace)}"
  pipe_role                = module.iam_roles.codepipeline_role_arn
  s3_bucket-us-east-1      = var.s3_bucket_id-us-east-1
  s3_bucket-ap-southeast-2 = var.s3_bucket_id-ap-southeast-2
  s3_bucket-eu-central-1   = var.s3_bucket_id-eu-central-1
  kms_key_arn-us-east-1       = data.aws_kms_key.kms_key-us-east-1.arn
  kms_key_arn-ap-southeast-2  = data.aws_kms_key.kms_key-ap-southeast-2.arn
  kms_key_arn-eu-central-1    = data.aws_kms_key.kms_key-ap-southeast-2.arn
  repo_owner               = var.repository_owner
  repo_name                = var.repository_names_microservices["abc"]
  branch                   = var.repository_branches_microservices["abc"]
 
  codebuild_project = module.codebuild_project.project_id
  
  app_name-us-east-1          = "${var.codedeploy_application_names["abc"]}-devuseast"
  deployment_group-us-east-1  = "${var.codedeploy_application_names["abc"]}-devuseast"
  
  app_name-ap-southeast-2          = "${var.codedeploy_application_names["abc"]}-devap"
  deployment_group-ap-southeast-2  = "${var.codedeploy_application_names["abc"]}-devap"
  
  app_name-eu-central-1          = "${var.codedeploy_application_names["abc"]}-deveu"
  deployment_group-eu-central-1  = "${var.codedeploy_application_names["abc"]}-deveu"
  
  crossaccount_role        = data.aws_iam_role.cross_account_role_for_target.arn

  providers = {
    "aws" = "aws.tools"
  }  
}
