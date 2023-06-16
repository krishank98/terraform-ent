resource "aws_vpc" "stage-vpc" {
    cidr_block="10.0.0.0/16"
    tags = {
        Name = "stagevpc"
        Environment="stage"
        Project="1"
    }
}

resource "aws_subnet" "stage-vpc-ps1"{
    vpc_id=aws_vpc.stage-vpc.id
    cidr_block="10.0.1.0/24"
    availability_zone = "ap-south-1a"
    tags = {
        Name= "stage-vpc-public-subnet-1"
        Environment="stage"
        Project="1"
    }
}

resource "aws_subnet" "stage-vpc-ps2"{
    vpc_id=aws_vpc.stage-vpc.id
    cidr_block="10.0.2.0/24"
    availability_zone = "ap-south-1b"
    tags = {
        Name= "stage-vpc-public-subnet-2"
        Environment="stage"
        Project="1"
    }
}

resource "aws_subnet" "stage-vpc-ps3"{
    vpc_id=aws_vpc.stage-vpc.id
    cidr_block="10.0.3.0/24"
    availability_zone = "ap-south-1a"
    tags = {
        Name= "stage-vpc-public-subnet-3"
        Environment="stage"
        Project="1"
    }
}

resource "aws_subnet" "stage-vpc-pvs1"{
    vpc_id=aws_vpc.stage-vpc.id
    cidr_block="10.0.4.0/24"
    availability_zone = "ap-south-1b"
    tags = {
        Name= "stage-vpc-private-subnet-1"
        Environment="stage"
        Project="1"
    }
}

resource "aws_subnet" "stage-vpc-pvs2"{
    vpc_id=aws_vpc.stage-vpc.id
    cidr_block="10.0.5.0/24"
    availability_zone = "ap-south-1a"
    tags = {
        Name= "stage-vpc-private-subnet-2"
        Environment="stage"
        Project="1"
    }
}

resource "aws_subnet" "stage-vpc-pvs3"{
    vpc_id=aws_vpc.stage-vpc.id
    cidr_block="10.0.6.0/24"
    availability_zone = "ap-south-1b"
    tags = {
        Name= "stage-vpc-private-subnet-3"
        Environment="stage"
        Project="1"
    }
}

resource "aws_route_table" "stage-vpc-public-route-table" {
    vpc_id=aws_vpc.stage-vpc.id

     route {
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.stage-igw.id
    }
      tags = {
        Name= "stage-vpc-public-routetable"
        Environment="stage"
        Project="1"
    }
}

resource "aws_main_route_table_association" "stage-vpc-main-id" {
    vpc_id =aws_vpc.stage-vpc.id
    route_table_id = aws_route_table.stage-vpc-public-route-table.id
}

resource "aws_route_table" "stage-vpc-private-route-table" {
    vpc_id=aws_vpc.stage-vpc.id

      tags = {
        Name= "stage-vpc-private-routetable"
        Environment="stage"
        Project="1"
    }
   
}

resource "aws_route_table_association" "pb1" {
    subnet_id=aws_subnet.stage-vpc-ps1.id
    route_table_id=aws_route_table.stage-vpc-public-route-table.id
}
resource "aws_route_table_association" "pb2" {
    subnet_id=aws_subnet.stage-vpc-ps2.id
    route_table_id=aws_route_table.stage-vpc-public-route-table.id
}
resource "aws_route_table_association" "pb3" {
    subnet_id=aws_subnet.stage-vpc-ps3.id
    route_table_id=aws_route_table.stage-vpc-public-route-table.id
}

resource "aws_route_table_association" "pv1" {
    subnet_id=aws_subnet.stage-vpc-pvs1.id
    route_table_id=aws_route_table.stage-vpc-private-route-table.id
}

resource "aws_route_table_association" "pv2" {
    subnet_id=aws_subnet.stage-vpc-pvs2.id
    route_table_id=aws_route_table.stage-vpc-private-route-table.id
}

resource "aws_route_table_association" "pv3" {
    subnet_id=aws_subnet.stage-vpc-pvs3.id
    route_table_id=aws_route_table.stage-vpc-private-route-table.id
}

resource "aws_internet_gateway" "stage-igw"{
    vpc_id=aws_vpc.stage-vpc.id
    tags = {
        Name="stage-igw"
        Environment="stage"
        Project="1"
    }
}

resource "aws_security_group" "stage-sg" {
  name        = "stagesg"
  vpc_id      = aws_vpc.stage-vpc.id

  ingress {
   
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
   
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
   
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "stage-vpc-ec2-sg"
  }
}
resource "aws_security_group" "alb-sg" {
    name = "stage-alb-sg"
    vpc_id = aws_vpc.stage-vpc.id

    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }   
     tags = {
    Name = "stage-vpc-alb-sg"
  }
}