resource "aws_instance" "server" {
   ami = var.amiid
   instance_type = var.type
   key_name = var.pemfile
   vpc_security_group_ids = [aws_security_group.instance_sg.id]
   subnet_id = aws_subnet.public_ap_south_1a.id
   availability_zone = data.aws_availability_zones.all.names[0]
   associate_public_ip_address = true

   user_data = <<EOF
#!/bin/bash
echo "Installing NodeExporter"
mkdir /home/ubuntu/node_exporter
cd /home/ubuntu/node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
tar node_exporter-1.2.2.linux-amd64.tar.gz
cd node_exporter-1.2.2.linux-amd64
./node_exporter &
echo "Changing Hostname"
EOF

   tags = {
    Name = "webserver-stageproject"
   }
}


resource "aws_instance" "dbserver" {
   ami = var.amiid
   instance_type = var.type
   key_name = var.pemfile
   vpc_security_group_ids = [aws_security_group.db_sg.id]
   subnet_id = aws_subnet.private_ap_south_1b.id
   availability_zone = data.aws_availability_zones.all.names[1]
   associate_public_ip_address = false

     tags = {
    Name = "dbserver-stageproject"
   }
}