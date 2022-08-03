
# ------- Creating ECS Cluster -------
module "ecs_cluster" {
  source = "./Modules/ECS/Cluster"
  name   = var.cluster_name
}

# ------- Creating ECS Task Definition for -------
module "ecs_taks_definition" {
  source             = "./Modules/ECS/TaskDefinition"
  name               = "${var.task_names["abc"]}-${lookup(var.environment_name,terraform.workspace)}"
  container_name     = "${var.container_names["abc"]}-${lookup(var.environment_name,terraform.workspace)}"
  execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = data.aws_iam_role.ecs_task_role.arn
  cpu                = 512
  memory             = "2048"
  docker_repo        = "${var.tools_account_id}.dkr.ecr.${var.aws_region_target}.amazonaws.com/${var.ecr_repository_names["abc"]}"
  region             = var.aws_region_target
  container_port     = var.container_ports["abc"]
}

# ------- Creating ECS Service -------
module "ecs_service" {
  source              = "./Modules/ECS/Service"
  name                = "${var.service_names["abc"]}-${lookup(var.environment_name,terraform.workspace)}"
  desired_tasks       = 1
  arn_security_group  = var.security_group_id
  ecs_cluster_id      = module.ecs_cluster.ecs_cluster_id
  arn_target_group    = module.target_group_blue.arn_tg
  arn_task_definition = module.ecs_taks_definition.arn_task_definition
  subnets_id          = var.subnet_ids
  container_port      = var.container_ports["abc"]
  container_name      = "${var.container_names["abc"]}-${lookup(var.environment_name,terraform.workspace)}"
}


# ------- Creating ECS Autoscaling policies -------
module "ecs_autoscaling" {
  depends_on   = [module.ecs_service]
  source       = "./Modules/ECS/Autoscaling"
  name         = "${var.service_names["abc"]}-${lookup(var.environment_name,terraform.workspace)}"
  cluster_name = module.ecs_cluster.ecs_cluster_name
  min_capacity = 1
  max_capacity = 4
}

