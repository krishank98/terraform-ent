provider "aws" {
    region = "ap-south-1"
}

module "IampolicyDev" {
    source = "../IampolicyDev"
}

module "IampolicyQa" {
    source = "../IampolicyQa"
}

resource "aws_iam_user" "demo" {
    name = var.name
    path = var.path
    force_destroy = var.force_destroy
    tags = {
        "testuser" = var.name
    }
}

resource "aws_iam_access_key" "demo" {
    user = aws_iam_user.demo.name
}

resource "aws_iam_user_policy" "demo1"{
    user =aws_iam_user.demo.name
    policy = var.demo.user ? module.IampolicyDev.policy : module.IampolicyQa.policy
}