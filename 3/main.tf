provider "aws" {
alias = "dev-account"
region = "ap-south-1"
profile = "dev"
}

resource "aws_instance" "my_instance1" {
    ami = "ami-0caf778a172362f1c"
    instance_type = "t2.micro"
  
}
resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket635622645"
}