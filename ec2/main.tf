data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}

resource "aws_instance" "ec2"{  #first lable is from terraform and second lable is any can be given by user for his ref
  ami = "ami-0a017d8ceb274537d"
  instance_type = var.instance_type
  vpc_security_group_ids = [var.sq_id]
  tags = {
    Name = var.component
  }

  provisioner "remote-exec" {
    connection {
      host = self.public_ip
      user = "centos"
      password = "DevOps321"
    }

    inline = [
      "git clone https://github.com/mettashalini89/Roboshop-scripting",
      "cd Robshop-scripting",
      "sudo bash ${var.component}.bash"

    ]

  }
}

resource "aws_security_group" "sq" {
  name        = "${var.component}-${var.env}-sq"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "ALL"
    from_port        = 0         #from and to port as 0 means allong traffic from all ports and #protocal -1 is also refer the same
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component}-${var.env}-sq"
  }
}

variable "component" {}
variable "instance_type" {}
variable "sq_id"{}
variable "env" {
  default = "dev"
}

output "private_ip"{
  value = aws_instance.ec2.private_ip
}