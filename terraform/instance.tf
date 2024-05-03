// instance.tf

variable "instance_name" {
  description = "Name of the instance"
}

variable "ami_id" {
  description = "AMI ID for the instance"
}

variable "instance_type" {
  description = "Type of the instance"
}

variable "security_group_name" {
  description = "Name of the security group"
}

resource "aws_instance" "custom_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [var.security_group_name]

  tags = {
    Name = var.instance_name
  }
}
