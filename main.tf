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
  no_of_instances = each.value["no_of_instances"]
  instance_class = each.value["instance_class"]
}

module "rds" {
  env = var.env
  source = "git::https://github.com/mettashalini89/tf_module_rds.git"
  subnet_ids = local.db_subnet_ids
  for_each = var.rds
  tags = var.tags
  engine = each.value["engine"]
  engine_version = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  no_of_instances = each.value["no_of_instances"]
  instance_class = each.value["instance_class"]
}

module "elasticache" {
  env = var.env
  source = "git::https://github.com/mettashalini89/tf_module_elasticache.git"
  subnet_ids = local.db_subnet_ids
  for_each = var.elasticache
  tags = var.tags
  engine = each.value["engine"]
  engine_version = each.value["engine_version"]
  num_cache_nodes = each.value["num_cache_nodes"]
  node_type = each.value["node_type"]

}

module "rabbitmq" {
  env = var.env
  source = "git::https://github.com/mettashalini89/tf_module_rabbitmq.git"
  subnet_ids = local.db_subnet_ids
  for_each = var.rabbitmq
  tags = var.tags

  instance_type = each.value["instance_type"]

}
*/

module "alb" {
  env = var.env
  source = "git::https://github.com/mettashalini89/tf_module_alb.git"
  subnet_ids = local.db_subnet_ids
  for_each = var.alb
  tags = var.tags

  name = each.value["name"]
  subnet_name = each.value["subnet_name"]
  internal = each.value["internal"]
  load_balancer_type = each.value["load_balancer_type"]
  subnets = lookup(local.subnet_ids, each.value["subnet_name"], null )
}






