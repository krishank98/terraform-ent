resource "aws_autoscaling_group" "stage-asg" {
    name = "stage-asg"
    max_size = 5
    min_size = 1
    desired_capacity = 1
    health_check_grace_period = 500
    health_check_type = "ELB"
    force_delete = true
    launch_configuration = aws_launch_configuration.stage-launch.name
    vpc_zone_identifier = [aws_subnet.stage-vpc-ps1.id,aws_subnet.stage-vpc-ps2.id]
}

resource "aws_launch_configuration" "stage-launch" {
    name_prefix = "stage-launch"
    image_id = "ami-0caf778a172362f1c"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.stage-sg.id]

    lifecycle {
        create_before_destroy = true
    }
}