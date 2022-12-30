# Time to wait for the instance to bootstrap with the script.
resource "time_sleep" "wait_for_instance" {
  create_duration = "180s"

  depends_on = [module.ec2_public]
}
