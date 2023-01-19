module "dimtheo_s3" {
    depends_on = [module.dimtheo_ec2]
    module_bucket_name = var.dimtheo_bucket
    module_bucket_acl_name = var.dimtheo_bucket
    module_ec2_public_ip = module.dimtheo_ec2.public_ip
    source = "./modules/S3"
}

module "dimtheo_ec2" {
    module_ami = var.dimtheo_ami
    module_instance_type = var.dimtheo_instance_type
    source = "./modules/EC2"
}