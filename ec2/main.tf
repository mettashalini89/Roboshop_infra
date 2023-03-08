data "aws_caller_identity" "current" {}

data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "devops-practice-with-ansible"
  owners           = [data.aws_caller_identity.current.account_id]
}

resource "aws_instance" "ec2"{  #first lable is from terraform and second lable is any can be given by user for his ref
  ami = data.aws_ami.ami.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sq.id]
  tags = {
    Name = var.component
  }
}

resource "null_resource" "provisioner" {      #Give provisioner saperately so it dnt destroy the resource creation

  provisioner "remote-exec" {
    connection {
      host = aws_instance.ec2.public_ip
      user = "centos"
      password = "DevOps321"
    }

    inline = [
      "ansible-pull -i localhost, -U https://github.com/mettashalini89/roboshop-ansible roboshop.yml -e role_name=${var.component}"

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

resource "aws_route53_record" "record" {
  zone_id = "Z02543141QBSJJNNYEJL"
  name    = "${var.component}-dev.devopsb71.live"
  type    = "A"
  ttl     = 30
  records = [aws_instance.ec2.private_ip]
}

variable "component" {}
variable "instance_type" {}

variable "env" {
  default = "dev"
}

