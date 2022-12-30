#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo yum install -y docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo service docker start
sudo usermod -a -G docker ec2-user
