# VPC
resource "aws_vpc" "a_vpc" {
  cidr_block = var.module_vpc_cidr
  tags = {
      Name = var.module_env
  }
}

# Créer une passerelle internet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.a_vpc.id
  tags = {
    Name : "${var.module_env} gateway"
  }
}

# Créer une table de routage personnalisée
resource "aws_route_table" "a_route_table" {
  vpc_id = aws_vpc.a_vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.gw.id
  }

  route {
      ipv6_cidr_block = "::/0"
      gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.module_env
  }
}

# Créer un sous-réseau
resource "aws_subnet" "subnet_1" {
    vpc_id = aws_vpc.a_vpc.id
    cidr_block = var.module_subnet_cidr
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.module_env}_subnet"
    }
}

# Associer la table de routage avec le sous-réseau
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.a_route_table.id
}

# Créer un groupe de sécurité pour autoriser le port 22, 80 et 443
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web traffic"
  vpc_id      = aws_vpc.a_vpc.id

  ingress {
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
      description      = "ICMP / ping"
      from_port        = 8
      to_port          = 0
      protocol         = "icmp"
      cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

# Créer une interface réseau avec une ip dans le sous-réseau créé précédemment
resource "aws_network_interface" "web_server_nic" {
  subnet_id       = aws_subnet.subnet_1.id
  private_ips     = [var.module_private_ip]
  security_groups = [aws_security_group.allow_web.id]

  tags = {
    Name : "${var.module_env}_network_interface"
  }
}

# Assigner une ip elastic à l'interface réseau créée dans l'étape précédente
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.web_server_nic.id
  associate_with_private_ip = var.module_private_ip
  depends_on = [aws_internet_gateway.gw, aws_instance.EC2_instance]
  tags = {
    Name : "${var.module_env}_elastic_ip"
  }
}

# Créer un serveur Amazon Linux
resource "aws_instance" "EC2_instance" {
    ami = var.module_ami
    instance_type = var.module_instance_type
    key_name = "vockey"

    network_interface {
        device_index = 0
        network_interface_id = aws_network_interface.web_server_nic.id
    }

    # Permet de créer une page web avec le message X depuis l'adresse IP publique du serveur
    user_data = <<-EOF
        #!/bin/bash
        sudo yum update -y
        sudo yum install httpd -y
        sudo systemctl start httpd
        sudo bash -c 'echo ${var.module_web_msg} > /var/www/html/index.html'
        EOF

    tags = {
      Name : "web_server"
    }
}