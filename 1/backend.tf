terraform{
    backend "s3" {
      bucket = "terraform-backend-3524"
      key = "1/terraform.tfstate"
      region = "ap-south-1"
    }
}