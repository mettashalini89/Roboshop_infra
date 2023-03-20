module "vpc" {
  env = var.env
  source = "git::https://github.com/mettashalini89/tf_module_vpc.git"
  for_each = var.vpc
  vpc_cidr = each.value["vpc_cidr"]
  tags = var.tags
}