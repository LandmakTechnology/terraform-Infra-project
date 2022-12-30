# Create a Null Resource and Provisioners
resource "null_resource" "dummy_resource" {
  depends_on = [aws_eip.ec2_eip]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = aws_eip.ec2_eip.public_ip
    user     = "ec2-user"
    password = ""
    private_key = file("private-key/Infrakey.pem")
  }

## File Provisioner: Copies the infra-team directory to /tmp/infra-team
  provisioner "file" {
    source      = "./infra-team"
    destination = "/tmp/infra/"
  }
## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sleep 10", "cd /tmp/infra/", "docker-compose up", "exit"
    ]
  }
  provisioner "local-exec" {
    command = "echo provisioner completed"
  }
}

/*
resource "null_resource" "completed" {
  provisioner "local-exec" {
    command = "echo provisioner completed"
  }
  triggers = {
    "dummy_resource" = "${null_resource.dummy_resource.id}"
  }
}*/
