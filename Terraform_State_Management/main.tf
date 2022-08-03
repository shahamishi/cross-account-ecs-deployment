resource "aws_kms_key" "terraform-bucket-key" {
 description             = "This key is used to encrypt bucket objects for Terraform State files"
 deletion_window_in_days = 10
 enable_key_rotation     = true
}

resource "aws_kms_alias" "key-alias" {
 name          = "alias/${var.state_purpose}-bucket-key-${lookup(var.environment_name,terraform.workspace)}-${var.aws_region_target}"
 target_key_id = aws_kms_key.terraform-bucket-key.key_id
}

resource "random_id" "RANDOM_ID_S3" {
  byte_length = "2"
}

resource "aws_s3_bucket" "terraform-state" {
 bucket = "tf-state-${var.state_purpose}-${lookup(var.environment_name,terraform.workspace)}-${var.aws_region_target}-${random_id.RANDOM_ID_S3.hex}"
 acl    = "private"

 versioning {
   enabled = true
 }

 server_side_encryption_configuration {
   rule {
     apply_server_side_encryption_by_default {
       kms_master_key_id = aws_kms_key.terraform-bucket-key.arn
       sse_algorithm     = "aws:kms"
     }
   }
 }
}

resource "aws_s3_bucket_public_access_block" "block" {
 bucket = aws_s3_bucket.terraform-state.id

 block_public_acls       = true
 block_public_policy     = true
 ignore_public_acls      = true
 restrict_public_buckets = true
}


resource "aws_dynamodb_table" "terraform-state" {
 name           = "terraform-${var.state_purpose}-state-${lookup(var.environment_name,terraform.workspace)}-${var.aws_region_target}"
 read_capacity  = 20
 write_capacity = 20
 hash_key       = "LockID"

 attribute {
   name = "LockID"
   type = "S"
 }
}
