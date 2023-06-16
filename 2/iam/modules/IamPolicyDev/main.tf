provider "aws" {
    region = "ap-south-1"
}

data "aws_iam_policy_document" "demo" {
    statement {
        effect = "Deny"
        actions = ["elasticbeanstalk:CreateEnvironment",
        "elasticbeanstalk:RebuildEnvironment",
        "elasticbeanstalk:TerminateEnvironment"
        ]
        resources = ["*"]
    }
    statement {
        effect = "Allow"
        actions = ["arn:aws:ec2:ap-south-1:532663929782:instance/*",
        "arn:aws:ec2:ap-south-1:532663929782:subnet-0ba82347"
        ]
     condition {
        test = "StringEquals" 
        variable = "ec2:InstanceType"
        values: ["t2.micro","t2.small"]
     }
    }
}
resource "aws_iam_policy" "dev" {
    name = "dev-policy"
    path = "/"
    policy = data.aws_iam_policy_document.demo.json
}