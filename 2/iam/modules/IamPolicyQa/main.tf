provider "aws" {
    region = "ap-south-1"
}

data "aws_iam_policy_document" "demoqa" {
    statement {
        effect = "Allow"
        actions = ["elasticbeanstalk:Check",
        "elasticbeanstalk:Describe",
        "elasticbeanstalk:List*",
        "elasticbeanstalk:RequestEnvironmentInfo*",
        "elasticbeanstalk:RetrieveEnvironmentInfo*",
        "ec2:Describe",
        "elasticloadbalancing:Describe",
        "autoscaling:Describe",
        "cloudwatch:Describe",
         "cloudwatch:List*",
         "cloudwatch:Get*",
         "s3:List*",
          "s3:Get*",
           "sns:Get*",
            "sns:List*",
            "rds:Describe",
             "cloudformation:Describe",
             "cloudformation:Get*",
             "cloudformation:List*",
             "cloudformation:Validate*",
             "cloudformation:Estimate*",
        ]
        resources = ["*"]
    }
    
}
resource "aws_iam_policy" "qa" {
    name = "qa-policy"
    path = "/"
    policy = data.aws_iam_policy_document.demoqa.json
}