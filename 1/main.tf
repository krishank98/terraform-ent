resource "aws_instance" "my_instance1" {
    ami = "ami-0caf778a172362f1c"
    instance_type = "t2.micro"
    key_name= "stage-key"
    subnet_id = aws_subnet.stage-vpc-ps1.id
    vpc_security_group_ids = [aws_security_group.stage-sg.id]
    associate_public_ip_address = true
    
    user_data = <<-EOL
     
      #!/bin/bash
      sudo apt update -y
      sudo apt install nginx -y
      sudo systemctl start nginx
      echo "ip addr()" >> /usr/share/nginx/html
      EOL

    tags ={
        Name = "my_instance1"
        Type = "Ubuntu"
        Env = "Stage"
    }
}

resource "aws_instance" "my_instance2" {
    ami = "ami-0caf778a172362f1c"
    instance_type = "t2.micro"
    key_name= "stage-key"
    subnet_id = aws_subnet.stage-vpc-ps1.id
    vpc_security_group_ids = [aws_security_group.stage-sg.id]
    associate_public_ip_address = true

    user_data = <<-EOL
     
      #!/bin/bash -xe
      apt update -y
      apt install nginx -y
      systemctl start nginx
      echo "ip addr()" >> /usr/share/nginx/index.html
      EOL

    tags ={
        Name = "my_instance2"
        Type = "Ubuntu"
        Env = "Stage"
    }
}