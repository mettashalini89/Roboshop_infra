resource "aws_ssm_parameter" "parameter" {
  count = length(var.parameters)
  name  = var.parameters[count.index].name
  type  = var.parameters[count.index].type
  value = var.parameters[count.index].value
}

resource "aws_ssm_parameter" "secret" {
  count = length(var.secrets)
  name  = var.secrets[count.index].name
  type  = var.secrets[count.index].type
  value = var.secrets[count.index].value
}

variable "parameters" {}
variable "secrets" {}

resource "aws_ssm_parameter" "jenkins_user" {
  name  = "jenkins.user"
  type  = "SecureString"
  value = "admin"
}

resource "aws_ssm_parameter" "jenkins_pass" {
  name  = "jenkins.pass"
  type  = "SecureString"
  value = "admin123"
}