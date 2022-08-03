# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0


output "arn_tg" {
  value = (var.create_target_group == true
  ? (length(aws_alb_target_group.target_group) > 0 ? aws_alb_target_group.target_group[0].arn : "") : "")
}

output "tg_name" {
  value = (var.create_target_group == true
  ? (length(aws_alb_target_group.target_group) > 0 ? aws_alb_target_group.target_group[0].name : "") : "")
}