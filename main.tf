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

  for_each = var.alb
  vpc_id = module.vpc["main"].vpc_id
  tags = var.tags
  allow_cidr = each.value["allow_cidr"]
  name = each.value["name"]
  internal = each.value["internal"]
  load_balancer_type = each.value["load_balancer_type"]
  subnets = lookup(local.subnet_ids, each.value["subnet_name"], null )
}

module "app" {
  env = var.env
  source = "git::https://github.com/mettashalini89/tf_module_app.git"
  for_each = var.apps
  tags = var.tags
  dns_domain = var.dns_domain
  vpc_id = module.vpc["main"].vpc_id
  bastion_cidr = var.bastion_cidr
  component = each.value["component"]
  instance_type = each.value["instance_type"]
  desired_capacity = each.value["desired_capacity"]
  max_size = each.value["max_size"]
  min_size = each.value["min_size"]
  subnets = lookup(local.subnet_ids, each.value["subnet_name"], null)
  port = each.value["port"]
  allow_app_to = lookup(local.subnet_cidr, each.value["allow_app_to"], null)
  alb_dns_name = lookup(lookup(lookup(module.alb, each.value["alb"], null ), "alb", null), "dns_name", null)
}

output "alb" {
  value = module.alb
}





