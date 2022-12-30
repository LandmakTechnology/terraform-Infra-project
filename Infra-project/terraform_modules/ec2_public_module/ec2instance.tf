# AWS EC2 Instance Terraform Module
# Infra Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"
  # insert the 10 required variables here
  name                   = "${local.name}-Instance"
  instance_count         = var.public_instance_count
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name              = var.instance_keypair
  #monitoring             = true
  subnet_id              = data.terraform_remote_state.network.outputs.public_subnets[0]
  vpc_security_group_ids  = [ data.terraform_remote_state.network.outputs.public_sg_group_id, data.terraform_remote_state.network.outputs.private_sg_group_id ]
  user_data = file("${path.module}/docker_install.sh")
  tags = local.common_tags

}
