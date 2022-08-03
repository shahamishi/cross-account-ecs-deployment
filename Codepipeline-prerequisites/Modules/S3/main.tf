# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*===========================
      AWS S3 resources
============================*/

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket_name
  //acl           = "private"
  force_destroy = true
  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = <<POLICY
 {
  "Version": "2012-10-17",
  "Id": "SSEAndSSLPolicy",
  "Statement": [
	{
  	"Sid": "DenyUnEncryptedObjectUploads",
	  "Effect": "Deny",
	  "Principal": "*",
	  "Action": "s3:PutObject",
	  "Resource": "arn:aws:s3:::${var.bucket_name}/*",
	  "Condition": {
		"StringNotEquals": {
		"s3:x-amz-server-side-encryption": "aws:kms"
		}
	   }
	 },
	{
	  "Sid": "DenyInsecureConnections",
	  "Effect": "Deny",
	  "Principal": "*",
	  "Action": "s3:*",
	  "Resource": "arn:aws:s3:::${var.bucket_name}/*",
	  "Condition": {
		"Bool": {
	  		"aws:SecureTransport": false
			}
		}
	  },
	{
	  "Sid": "",
	  "Effect": "Allow",
	  "Principal": {
		"AWS": "arn:aws:iam::${var.target_account_id}:root"
		},
	  "Action": [
            "s3:Get*",
            "s3:Put*"
        ],
	  "Resource": "arn:aws:s3:::${var.bucket_name}/*"
	},
	{
	  "Sid": "",
	  "Effect": "Allow",
	  "Principal": {
	      "AWS": "arn:aws:iam::${var.target_account_id}:root"
			},
	  "Action": "s3:ListBucket",
  	"Resource": "arn:aws:s3:::${var.bucket_name}"
	}
   ]
} 
POLICY

}