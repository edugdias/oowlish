# Provider 
provider "aws" {
  region = "sa-east-1"
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "sa-east-1c"
  tags = {
    Name = "Default subnet for sa-east-1c"
  }
}

resource "aws_security_group" "oowlish-sg" {
  name ="oowlish-eduardo-dias"
  ingress{
    from_port   = var.server_port_ssh
    to_port     = var.server_port_ssh
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port   = var.server_app_port
    to_port     = var.server_app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "oowlish-eduardo-dias"{
  key_name               = var.key_name
  ami                    = var.ami
  instance_type          = var.ec2Type
  vpc_security_group_ids = [aws_security_group.oowlish-sg.id]

  provisioner "file" {
    source      = "./install_and_run.sh"
    destination = "/tmp/install_and_run.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_and_run.sh",
      "/tmp/install_and_run.sh",
    ]
  }

  connection {
    type        = "ssh"
    user        = var.sshUser
    private_key = file(var.sshKey)
    host        = self.public_ip
  }
}

variable "server_port_ssh" {
 description = "The port to be used by SSH requests"
 default = 22
}

variable "server_app_port" {
 description = "The port to be used by App requests"
 default = 8000
}

variable "sshKey" {
   default = "~/Downloads/oowlish.pem"
}

variable "sshUser" {
   default = "ec2-user"
}

variable "key_name" {
   default = "oowlish"
}

variable "ami" {
   default = "ami-0a52e8a6018e92bb0"
}

variable "ec2Type" {
   default = "t2.micro"
}