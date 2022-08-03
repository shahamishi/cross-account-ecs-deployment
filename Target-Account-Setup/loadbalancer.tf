
# ------- Creating Target Group for the server ALB blue environment -------
module "target_group_thread_tokenization_blue" {
  source              = "./Modules/ALB"
  create_target_group = true
  create_listerner_rule = true
  name                = "tg-${lookup(var.environment_name,terraform.workspace)}-abc-test-b"
  port                = 80
  protocol            = "HTTP"
  vpc                 = var.vpc_id
  tg_type             = "ip"
  health_check_path   = var.health_check_paths["abc"]
  health_check_port   = var.container_ports["abc"]
  listener_arn       = [data.aws_lb_listener.listener443.arn]//,data.aws_lb_listener.listener80.arn]
  condition_path     = var.listerner_rule_condition_path["abc"]  

}

# ------- Creating Target Group for the server ALB green environment -------
module "target_group_thread_tokenization_green" {
  source              = "./Modules/ALB"
  create_target_group = true
  name                = "tg-${lookup(var.environment_name,terraform.workspace)}-abc-test-g"
  port                = 80
  protocol            = "HTTP"
  vpc                 = var.vpc_id
  tg_type             = "ip"
  health_check_path   = var.health_check_paths["abc"]
  health_check_port   = var.container_ports["abc"]
  listener_arn       = [data.aws_lb_listener.listener443.arn]//,data.aws_lb_listener.listener80.arn]

}
