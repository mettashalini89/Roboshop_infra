locals {

  subnet_ids = {
    db = tolist([module.vpc["main"].private_subnets["db-az1"].id, module.vpc["main"].private_subnets["db-az2"].id])
    app = tolist([module.vpc["main"].private_subnets["app-az1"].id, module.vpc["main"].private_subnets["app-az2"].id])
    web = tolist([module.vpc["main"].private_subnets["web-az1"].id, module.vpc["main"].private_subnets["web-az2"].id])
    public = tolist([module.vpc["main"].public_subnets["public-az1"].id, module.vpc["main"].public_subnets["public-az2"].id])
  }
  subnet_cidr = {
    db = tolist([module.vpc["main"].private_subnets["db-az1"].cidr_bock, module.vpc["main"].private_subnets["db-az2"].cidr_bock])
    app = tolist([module.vpc["main"].private_subnets["app-az1"].cidr_bock, module.vpc["main"].private_subnets["app-az2"].cidr_bock])
    web = tolist([module.vpc["main"].private_subnets["web-az1"].cidr_bock, module.vpc["main"].private_subnets["web-az2"].cidr_bock])
    public = tolist([module.vpc["main"].public_subnets["public-az1"].cidr_bock, module.vpc["main"].public_subnets["public-az2"].cidr_bock])
  }

  db_subnet_ids  = tolist([module.vpc["main"].private_subnets["db-az1"].id, module.vpc["main"].private_subnets["db-az2"].id])
  app_subnet_ids = tolist([module.vpc["main"].private_subnets["app-az1"].id, module.vpc["main"].private_subnets["app-az2"].id])
  web_subnet_ids = tolist([module.vpc["main"].private_subnets["web-az1"].id, module.vpc["main"].private_subnets["web-az2"].id])
}