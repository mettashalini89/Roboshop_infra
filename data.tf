
/*
data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "devops-practice-with-ansible"
  owners           = ["self"]
}
*/

data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}


data "aws_ssm_parameter" "ssh_pass"{
  name = "${var.env}.ssh.pass"
}

