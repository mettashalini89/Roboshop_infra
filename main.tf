module "vpc" {
  env = var.env
  source = "git::https://github.com/mettashalini89/tf_module_vpc.git"
  for_each = var.vpc
  vpc_cidr = each.value["vpc_cidr"]
  tags = var.tags
  default_vpc_id = var.default_vpc_id
  default_vpc_route_table = var.default_vpc_route_table
  public_subnets = each.value["public_subnets"]
  private_subnets = each.value["private_subnets"]
}

/*
module "docdb" {
  env = var.env
  source = "git::https://github.com/mettashalini89/tf_module_docdb.git"
  for_each = var.docdb
  tags = var.tags
  engine = each.value["engine"]
  engine_version = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot = each.value["skip_final_snapshot"]
  subnet_ids = local.db_subnet_ids

}
*/

