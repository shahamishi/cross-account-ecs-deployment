module "codedeploy_thread_tokenization" {
  source          = "./Modules/CodeDeploy"
  name            = "${var.codedeploy_application_names["abc"]}-${lookup(var.environment_name,terraform.workspace)}"
  ecs_cluster     = module.ecs_cluster.ecs_cluster_name
  ecs_service     = module.ecs_service.ecs_service_name
  alb_listener    = [data.aws_lb_listener.listener443.arn,data.aws_lb_listener.listener80.arn]
  tg_blue         = module.target_group_blue.tg_name
  tg_green        = module.target_group_green.tg_name
  codedeploy_role = data.aws_iam_role.codedeploy_role.arn
}