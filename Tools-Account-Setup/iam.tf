module "iam_roles" {
  source                       = "./Modules/IAM"
  
  name_codepipeline_role       = var.iam_role_name["codepipeline"]
  name_cross_account_role      = var.iam_role_name["cross_account_role_for_target"] 
  
  target_account_id            = var.accounts["target"]

  ecr_repositories             = [
  "arn:aws:ecr:us-east-1:230169046312:repository/openjdk",
  module.ecr-us-east-1.ecr_repository_arn,
  module.ecr-ap-southeast-2.ecr_repository_arn,
  module.ecr-eu-central-1.ecr_repository_arn
  ]
  
  code_build_projects          = [
  module.codebuild_project.project_arn ] 
  
  code_deploy_resources        = [


"arn:aws:codedeploy:us-east-1:${var.accounts["target"]}:deploymentgroup:${var.codedeploy_application_names["abc"]}-devuseast/${var.codedeploy_application_names["abc"]}-devuseast",
"arn:aws:codedeploy:us-east-1:${var.accounts["target"]}:application:${var.codedeploy_application_names["abc"]}-devuseast",
"arn:aws:codedeploy:us-east-1:${var.accounts["target"]}:deploymentgroup:${var.codedeploy_application_names["abc"]}-devap/${var.codedeploy_application_names["abc"]}-devap",
"arn:aws:codedeploy:us-east-1:${var.accounts["target"]}:application:${var.codedeploy_application_names["abc"]}-devap",
"arn:aws:codedeploy:us-east-1:${var.accounts["target"]}:deploymentgroup:${var.codedeploy_application_names["abc"]}-deveu/${var.codedeploy_application_names["abc"]}-deveu",
"arn:aws:codedeploy:us-east-1:${var.accounts["target"]}:application:${var.codedeploy_application_names["abc"]}-deveu",
   ] 
  providers = {
    aws.tools = aws.tools
  } 
  
}