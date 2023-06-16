resource "aws_lb" "example" {
    name = "alb-stage"
    security_groups = [aws_security_groups.elb-sg.id]
    availibilty_zones = data.aws_avalibility_zones.all.names[1]

    healthcheck {
        target = "HTTP:${var.server_port}/"
        internal = 30
        timout = 30
        healthy_threshold = 2
        unhealthy_threshold = 2
    }

    listner {
        lb_port = var.elb_port
        lb_protocol = "http"
        instance_port = var.server_port
        instance_protocol = "http"
    }

}

resource "aws_security_groups" "elb-sg" {
    name = "elb for sg"
    egress {
        from_port = 80
        to_port = 80
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.elb_port
        to_port = var.elb_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_groups" "instance-sg" {
    name = "instance for sg"
    egress {
        from_port = 80
        to_port = 80
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_launch_configuration" "example" {
  name = "launch_configuration"
  ami_id = "ami-0620d12a9cf777c87"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
  #!/bin/bash
  echo "<html><body><h1 >page </h1></body></html>
  nohup busybox httpd -f -p "%{var.server_port}" &
  EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
    name = "asg"
    launch_configuration = aws_launch_configuration.example.id
    availibilty_zones = data.aws_avalibility_zones.all.names
    min_size = 2
    max_size = 10
    load_balancers = [aws_lb.example.name]
    health_check_type = "ELB"

    tags = {
        key = " name "
        value = "shdhs"
        propogate_at_launch = true 
    }

}

