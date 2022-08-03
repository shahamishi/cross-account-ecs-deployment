# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "bucket_name" {
  description = "The name of your S3 bucket"
  type        = string
}

variable "target_account_id" {
  type = string
}