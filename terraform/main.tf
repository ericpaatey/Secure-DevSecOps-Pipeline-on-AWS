terraform {

  backend "s3" {

    bucket = "secure-devsecops-terraform-state"

    key = "terraform.tfstate"

    region = "us-east-1"

    dynamodb_table = "terraform-locks"
  }
}

resource "aws_s3_bucket" "terraform_state" {

  bucket = "secure-devsecops-terraform-state"
}

resource "aws_dynamodb_table" "terraform_locks" {

  name = "terraform-locks"

  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}