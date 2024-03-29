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
  vpc_id = module.vpc["main"].vpc_id
  no_of_instances = each.value["no_of_instances"]
  instance_class = each.value["instance_class"]
  allow_subnets  = lookup(local.subnet_cidr, each.value["allow_subnets"], null)
}

module "rds" {
  env = var.env
  source = "git::https://github.com/mettashalini89/tf_module_rds.git"
  subnet_ids = local.db_subnet_ids
  for_each = var.rds
  tags = var.tags
  vpc_id = module.vpc["main"].vpc_id
  engine = each.value["engine"]
  engine_version = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  no_of_instances = each.value["no_of_instances"]
  instance_class = each.value["instance_class"]
  allow_subnets  = lookup(local.subnet_cidr, each.value["allow_subnets"], null)
}

module "elasticache" {
  env = var.env
  source = "git::https://github.com/mettashalini89/tf_module_elasticache.git"
  subnet_ids = local.db_subnet_ids
  for_each = var.elasticache
  tags = var.tags
  vpc_id = module.vpc["main"].vpc_id
  engine = each.value["engine"]
  engine_version = each.value["engine_version"]
  num_cache_nodes = each.value["num_cache_nodes"]
  node_type = each.value["node_type"]
  allow_subnets  = lookup(local.subnet_cidr, each.value["allow_subnets"], null)

}

module "rabbitmq" {
  depends_on = [module.vpc]
  env = var.env
  source = "git::https://github.com/mettashalini89/tf_module_rabbitmq.git"
  subnet_ids = local.db_subnet_ids
  dns_domain = var.dns_domain
  bastion_cidr = var.bastion_cidr
  for_each = var.rabbitmq
  tags = var.tags
  vpc_id = module.vpc["main"].vpc_id

  instance_type = each.value["instance_type"]
  allow_subnets  = lookup(local.subnet_cidr, each.value["allow_subnets"], null)

}

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

/*
module "app" {
  depends_on = [module.vpc,module.alb, module.docdb, module.elasticache, module.rabbitmq, module.rds]
  env = var.env
  source = "git::https://github.com/mettashalini89/tf_module_app.git"
  for_each = var.apps
  tags = var.tags
  dns_domain = var.dns_domain
  vpc_id = module.vpc["main"].vpc_id
  bastion_cidr = var.bastion_cidr
  monitoring_nodes = var.monitoring_nodes
  component = each.value["component"]
  instance_type = each.value["instance_type"]
  listner_priority   = each.value["listner_priority"]
  desired_capacity = each.value["desired_capacity"]
  max_size = each.value["max_size"]
  min_size = each.value["min_size"]
  subnets = lookup(local.subnet_ids, each.value["subnet_name"], null)
  port = each.value["port"]
  alb = each.value["alb"]
  parameters = each.value["parameters"]
  allow_app_to = lookup(local.subnet_cidr, each.value["allow_app_to"], null)
  alb_dns_name = lookup(lookup(lookup(module.alb, each.value["alb"], null ), "alb", null), "dns_name", null)
  listner_arn = lookup(lookup(lookup(module.alb, each.value["alb"], null ), "listner", null), "arn", null)
}
*/


/*
### load runner
resource "aws_spot_instance_request" "load-runner" {
  ami           = data.aws_ami.ami.id
  instance_type = "t3.medium"
  wait_for_fulfillment = true
  vpc_security_group_ids = ["sg-043fd9cc9443cbb75"]

  tags = merge(
    var.tags,
    {Name = "load-runner"}
  )
}

resource "aws_ec2_tag" "name-tag" {
  key         = "Name"
  resource_id = aws_spot_instance_request.load-runner.spot_instance_id
  value       = "load-runner"
}

resource "null_resource" "load-gen" {
  triggers = {
    abc = aws_spot_instance_request.load-runner.public_ip
  }
  provisioner "remote-exec" {
    connection {
      host = aws_spot_instance_request.load-runner.public_ip
      user = "root"
      password = data.aws_ssm_parameter.ssh_pass.value
    }

    inline = [

      "curl -s -L https://get.docker.com | bash &>/dev/null",
      "systemctl enable docker",
      "systemctl start docker",
      "docker pull robotshop/rs-load"

    ]

  }
}


module "minikube" {
  source = "github.com/scholzj/terraform-aws-minikube"

  aws_region    = "us-east-1"
  cluster_name  = "my-minikube"
  aws_instance_type = "t3.medium"
  ssh_public_key = "~/.ssh/id_rsa.pub"
  aws_subnet_id = lookup(local.subnet_ids, "public", null )[0]
  hosted_zone = "devopsb71.live"
  hosted_zone_private = false

  tags = {
    Name = "Minikube"
  }

  addons = [
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/storage-class.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/heapster.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/dashboard.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/external-dns.yaml"
  ]
}

output "MINIKUBE_SERVER" {
  value = "ssh centos@${module.minikube.public_ip}"
}

output "KUBE_CONFIG" {
  value = "scp centos@${module.minikube.public_ip}:/home/centos/kubeconfig ~/.kube/config"
}
*/

module "eks" {
  source                 = "github.com/r-devops/tf-module-eks"
  ENV                    = var.env
  PRIVATE_SUBNET_IDS     = lookup(local.subnet_ids, "app", null )
  PUBLIC_SUBNET_IDS      = lookup(local.subnet_ids, "public", null )
  DESIRED_SIZE           = 1
  MAX_SIZE               = 1
  MIN_SIZE               = 1
  //CREATE_PARAMETER_STORE = true
}