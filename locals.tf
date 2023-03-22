locals {
  db_subnet_ids = tolist([module.vpc["main"].private_subnets["db-az1"].id, module.vpc["main"].private_subnets["db-az2"].id])
  app_subnet_ids = tolist([module.vpc["main"].private_subnets["app-az1"].id, module.vpc["main"].private_subnets["app-az2"].id])
  web_subnet_ids = tolist([module.vpc["main"].private_subnets["web-az1"].id, module.vpc["main"].private_subnets["web-az2"].id])
}