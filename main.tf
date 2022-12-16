

### Instance EC2 (VM)
####     ----> SSH-PUBLIC-KEY --> DONE
####     ----> SG (Sécurity Group) [22/TCP]  --> DONE


resource "aws_key_pair" "myssh-key" {

  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjn7Aa2ew5OIi/AlMgaMJQqQznBUjLSov6nXyIvZYdidCe1Ki17BTWuj0GCT3hw+ZDYE5cVnRJkEwydXbEnp2kFonkTeevfMcNajXSkNNF0QpSRRYOuW1f41/uO5bNiDWbqkwtFSR7jPDAQDYG23WsqHBSs42k3dYI3lOhG4LWf3n+lBVVPlON6oQxi4eccLtWyh/9hWoVcd+mZ7c68bLTI6vLRfuFdjbcf4ruDVsr0duHQ/TlSgWOUjDDTru+ryvYC23xfDKCrNKdrjWuOnO+goaHj8Y/LX33DB2rT5kHlZ7+9sFq1TlK9aXdA38kCPuUqZylyvbudsd+FCBEp0gmhroKrzd8jON6TPANxt75JZh5utSre66WlAU0046vDYYzzd8pd9G5OFN3veCV/XTGRWpZvVPUbhqZeEoGTYIrQmepR0Z89JCKVK2i9zARmXYg8GjWdSHewOafstIj2nzsbiojIhC2jBvy9DOZtNVOFHGDQMRYOu0IKH/FU8+hFj0= wettayeb@darkos"

}


resource "aws_security_group" "my-sg" {

  description = "Security group to allow incoming SSH connection to ec2 instance"
  name        = "my_sg"

  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow SSH"
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "TCP"
    security_groups  = []
    self             = false
    to_port          = 22
  }]

  egress = [{
    description      = "Allow connection to any internet service"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    self             = false
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []

  }]

}


resource "aws_instance" "myec2" {

  ami             = ""
  instance_type   = "t2.medium"
  key_name        = aws_key_pair.myssh-key.key_name # 1ère variable terraform
  security_groups = [aws_security_group.my-sg.name]


}