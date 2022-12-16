# Variables SSH


# Nom de la paire de clés SSH
variable "ssh_key_name" {
  type = string
}

# Clé publique de la paire de clés SSH
variable "public_ssh_key" {
  type = string
}

# Variables SG
# Nom du groupe de sécurité
variable "sg_name" {
  type = string
}

# Protocole pour la règle d'entrée du groupe de sécurité
variable "sg_ingress_protocol" {
  type = string
}

# Port de début pour la règle d'entrée du groupe de sécurité
variable "sg_ingress_from_port" {
  type = number
}

# Port de fin pour la règle d'entrée du groupe de sécurité
variable "sg_ingress_to_port" {
  type = number
}

# Liste des blocs CIDR autorisés à accéder au groupe de sécurité
variable "sg_ingress_cidr_blocks" {
  type = list(string)
}

# Protocole pour la règle de sortie du groupe de sécurité
variable "sg_egress_protocol" {
  type = string
}

# Port de début pour la règle de sortie du groupe de sécurité
variable "sg_egress_from_port" {
  type = number
}

# Port de fin pour la règle de sortie du groupe de sécurité
variable "sg_egress_to_port" {
  type = number
}

# Liste des blocs CIDR autorisés à être accessibles depuis le groupe de sécurité
variable "sg_egress_cidr_blocks" {
  type = list(string)
}

# Variables EC2
# ID de l'AMI pour l'instance EC2
variable "ec2_ami" {
  type = string
}

# Type d'instance pour l'instance EC2
variable "ec2_instance_type" {
  type = string
}

# Nom de l'instance EC2
variable "ec2_name" {
  type = string
}
