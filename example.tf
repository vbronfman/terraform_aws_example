terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "MyKeyPair"
  public_key = file(var.public_key)
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
 # region  = " ${var.region}"
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = aws_key_pair.deployer.key_name


  tags = {
    Name = "Learn-Terraform"
  }

connection {
    private_key = file(var.private_key)
    agent       = false
    timeout     = "2m"
    #user        = var.ansible_user
    user= "ec2-user"
   # host        = self.public_ip
    host        = aws_instance.example.public_ip
  }

provisioner "local-exec" {
  command = "echo The server's IP address is ${self.associate_public_ip_address}"
}

# force Terraform to wait until a connection can be made, so that Ansible doesn't fail when trying to provision
provisioner "remote-exec" {
  # The connection will use the local SSH agent for authentication
  inline = ["echo Successfully connected"]
  }

# Copies the ** file to **
  #provisioner "file" {
 #   source      = "../Infinidate_challenge/.ansible/"
 #   destination = "/root"
 # }

# Copies the ** file to **
 # provisioner "file" {
 #   source      = "../Infinidate_challenge/infinidat_playbook.yml"
 #   destination = "/work"
 # }

provisioner "remote-exec" {
  # The connection will use the local SSH agent for authentication
  inline = ["sudo yum update -y"]
  }

  # We run a remote provisioner on the instance after creating it.
 # provisioner "file" {
    #  source = ".install_ansible/"
    #  destination = "/tmp/"
  #} 

  #provisioner "remote-exec" {
  # inline = [
  #      "sh /tmp/install-docker.sh",
  #      "sh /tmp/download-docker-images.sh", 
  #      "sh /tmp/run-axis-server.sh",
  #      "sh /tmp/run-esb.sh"
  #  ]
  #}



}
