provider "aws" {
    region = "ap-south-1"
}

resource "aws_s3_bucket" "example" {
    bucket ="terraform-backend-3524"
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
    name = "terraform-state-lock-dynamo3524"
    hask_key = "LockID"
    read_capacity = 20
    write_capacity = 20
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        Name = "terraform-state-lock-dynamo3524"
    }
}