variable "module_env" {
  description = "Type d'environment (dev, prod, etc.)"
  default = "prod"
  type = string
}

variable "module_ami" {
  description = "Nom de l'ami"
  type = string
}

variable "module_instance_type" {
  description = "Nom du type de l'instance"
  type = string
}

variable "module_vpc_cidr" {
  description = "Bloc cidr unique pour le vpc"
  default = "10.0.0.0/16"
  type = string
}

variable "module_subnet_cidr" {
  description = "Bloc cidr unique pour le sous-réseaux"
  default = "10.0.1.0/24"
  type = string
}

variable "module_private_ip" {
  description = "IP privée unique pour l'interface réseau"
  default = "10.0.1.50"
  type = string
}

variable "module_web_msg" {
  description = "Message de la page Web"
  default = "Terraform c'est cool"
  type = string
}
