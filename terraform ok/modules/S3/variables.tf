variable "module_bucket_name" {
  description = "Nom du Bucket S3"
  type = string
}

variable "module_bucket_acl_name" {
  description = "Nom de l'acl"
  type = string
}

variable "module_ec2_public_ip" {
  description = "Adresse IP de l'EC2"
  type = string
}

variable "acl_value" {
  description = "Defini l'acces au bucket"
  default = "public-read"
}