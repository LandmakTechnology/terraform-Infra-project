# Create Elastic IP for Bastion Host
# Resource - depends_on Meta-Argument
resource "aws_eip" "ec2_eip" {
  depends_on = [ time_sleep.wait_for_instance ]
  instance = module.ec2_public.id[0]
  vpc      = true
  tags = local.common_tags

}
