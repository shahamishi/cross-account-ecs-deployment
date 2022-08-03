# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*==============================================================
      AWS Application Load Balancer + Target groups
===============================================================*/

# ------- Target Groups for ALB US-EAST-1-------
resource "aws_alb_target_group" "target_group" {
  count                = var.create_target_group == true ? 1 : 0
  name                 = var.name
  port                 = var.port
  protocol             = var.protocol
  vpc_id               = var.vpc
  target_type          = var.tg_type
  deregistration_delay = 5

  health_check {
    enabled             = true
    interval            = 300
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.protocol
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_rule" "static" {
  count       = var.create_listerner_rule == true ? length(var.listener_arn) : 0
  listener_arn = var.listener_arn[count.index]
  //priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group[0].arn
  }

  condition {
    path_pattern {
      values = [var.condition_path]
    }
  }

}
