env = "prod"
bastion_cidr = [ "172.31.3.108/32" ]
monitoring_nodes = [ "172.31.3.158/32"]
dns_domain = "devopsb71.live"

vpc = {
  main = {
    vpc_cidr = "10.255.0.0/16"

    public_subnets = {
      public-az1 = {
        name = "public-az1"
        cidr_block = "10.255.0.0/24"
        availability_zone = "us-east-1a"
      }
      public-az2 = {
        name = "public-az2"
        cidr_block = "10.255.1.0/24"
        availability_zone = "us-east-1b"

      }
    }

    private_subnets = {
      web-az1 = {
        name = "web-az1"
        cidr_block = "10.255.2.0/24"
        availability_zone = "us-east-1a"
      }
      web-az2 = {
        name = "web-az2"
        cidr_block = "10.255.3.0/24"
        availability_zone = "us-east-1b"

      }
      app-az1 = {
        name = "app-az1"
        cidr_block = "10.255.4.0/24"
        availability_zone = "us-east-1a"
      }
      app-az2 = {
        name = "app-az2"
        cidr_block = "10.255.5.0/24"
        availability_zone = "us-east-1b"

      }
      db-az1 = {
        name = "db-az1"
        cidr_block = "10.255.6.0/24"
        availability_zone = "us-east-1a"
      }
      db-az2 = {
        name = "db-az2"
        cidr_block = "10.255.7.0/24"
        availability_zone = "us-east-1b"

      }
    }
  }
}

docdb = {
  main = {
    engine = "docdb"
    backup_retention_period = 2
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot  = true
    engine_version ="4.0.0"
    no_of_instances = 1
    instance_class = "db.t3.medium"
    allow_subnets  = "app"
  }
}

rds = {
  main = {
    engine = "aurora-mysql"
    backup_retention_period = 1
    preferred_backup_window = "07:00-09:00"
    engine_version = "5.7.mysql_aurora.2.11.1"
    no_of_instances = 1
    instance_class = "db.t3.small"
    allow_subnets  = "app"
  }
}


elasticache = {
  main = {
    engine = "redis"
    engine_version = "6.x"
    num_cache_nodes = 1
    node_type = "cache.t3.micro"
    allow_subnets  = "app"
  }
}

rabbitmq = {
  main = {
    instance_type = "t3.micro"
    allow_subnets  = "app"
  }
}

alb = {
  public = {
    subnet_name = "public"
    name = "public"
    internal = false
    load_balancer_type = "application"
    allow_cidr = [ "0.0.0.0/0" ]
  }

  private = {
    subnet_name = "app"
    name = "private"
    internal = true
    load_balancer_type = "application"
    allow_cidr = [ "10.255.2.0/24", "10.255.3.0/24", "10.255.4.0/24", "10.255.5.0/24" ]
  }
}

apps = {
  catalogue = {
    component = "catalogue"
    instance_type = "t3.micro"
    desired_capacity   = 2
    max_size           = 10
    min_size           = 2
    subnet_name        = "app"
    port               = 8080
    allow_app_to       = "app"
    alb                = "private"
    listner_priority   = 10
    parameters         = ["docdb"]
  }
  cart = {
    component = "cart"
    instance_type = "t3.micro"
    desired_capacity   = 2
    max_size           = 10
    min_size           = 2
    subnet_name        = "app"
    port               = 8080
    allow_app_to       = "app"
    alb                = "private"
    listner_priority   = 11
    parameters         = ["elasticache"]
  }
  user = {
    component = "user"
    instance_type = "t3.micro"
    desired_capacity   = 2
    max_size           = 10
    min_size           = 2
    subnet_name        = "app"
    port               = 8080
    allow_app_to       = "app"
    alb                = "private"
    listner_priority   = 12
    parameters         = ["docdb", "elasticache"]
  }
  shipping = {
    component = "shipping"
    instance_type = "t3.medium"
    desired_capacity   = 2
    max_size           = 10
    min_size           = 2
    subnet_name        = "app"
    port               = 8080
    allow_app_to       = "app"
    alb                = "private"
    listner_priority   = 13
    parameters         = ["rds"]
  }
  payment = {
    component = "payment"
    instance_type = "t3.micro"
    desired_capacity   = 2
    max_size           = 10
    min_size           = 2
    subnet_name        = "app"
    port               = 8080
    allow_app_to       = "app"
    alb                = "private"
    listner_priority   = 14
    parameters         = ["rabbitmq"]
  }
  frontend = {
    component = "frontend"
    instance_type = "t3.micro"
    desired_capacity   = 2
    max_size           = 10
    min_size           = 2
    subnet_name        = "web"
    port               = 80
    allow_app_to       = "public"
    alb                = "public"
    listner_priority   = 10
    parameters         = []
  }
}























