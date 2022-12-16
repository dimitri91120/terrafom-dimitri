# Configuration SSH
resource "aws_key_pair" "myssh-key" {
  key_name   = var.ssh_key_name
  public_key = var.public_ssh_key
}

# Configuration SG
resource "aws_security_group" "my-sg" {
  name = var.sg_name

  ingress = [{
    cidr_blocks      = var.sg_ingress_cidr_blocks
    description      = "Autoriser SSH"
    from_port        = var.sg_ingress_from_port
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = var.sg_ingress_protocol
    security_groups  = []
    self             = false
    to_port          = var.sg_ingress_to_port
  }]

  egress = [{
    description      = "Allow connection to any internet service"
    from_port        = 0
    to_port          = 0
    protocol         = var.sg_egress_protocol
    cidr_blocks      = var.sg_egress_cidr_blocks
    self             = false
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []

  }]

}

# Configuration EC2
resource "aws_instance" "myec2" {

  ami             = var.ec2_ami
  instance_type   = var.ec2_instance_type
  key_name        = aws_key_pair.myssh-key.key_name
  security_groups = [aws_security_group.my-sg.name]
  tags = {
    "Name" = var.ec2_name
  }

}
