env = "dev"

vpc = {
  main = {
    vpc_cidr = "10.0.0.0/16"

    public_subnets = {
      public-az1 = {
        name = "public-az1"
        cidr_block = "10.0.0.0/24"
        availability_zone = "us-east-1a"
      }
      public-az2 = {
        name = "public-az2"
        cidr_block = "10.0.1.0/24"
        availability_zone = "us-east-1b"

      }
    }

    private_subnets = {
      web-az1 = {
        name = "web-az1"
        cidr_block = "10.0.2.0/24"
        availability_zone = "us-east-1a"
      }
      web-az2 = {
        name = "web-az2"
        cidr_block = "10.0.3.0/24"
        availability_zone = "us-east-1b"

      }
      app-az1 = {
        name = "app-az1"
        cidr_block = "10.0.4.0/24"
        availability_zone = "us-east-1a"
      }
      app-az2 = {
        name = "app-az2"
        cidr_block = "10.0.5.0/24"
        availability_zone = "us-east-1b"

      }
      db-az1 = {
        name = "db-az1"
        cidr_block = "10.0.6.0/24"
        availability_zone = "us-east-1a"
      }
      db-az2 = {
        name = "db-az2"
        cidr_block = "10.0.7.0/24"
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
    skip_final_snapshot     = true
    engine_version ="4.0.0"
    storage_encrypted = true
  }
}