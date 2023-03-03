variable "instances" {
  default = {
    frontend = {
      name = "frontend"
      type = "t3.micro"
    }
    catalogue = {
      name = "catalogue"
      type = "t3.micro"
    }
    cart = {
      name = "cart"
      type = "t3.micro"
    }
    redis = {
      name = "redis"
      type = "t3.micro"
    }
    user = {
      name = "user"
      type = "t3.micro"
    }
    shipping = {
      name = "shipping"
      type = "t3.micro"
    }
    payment = {
      name = "payment"
      type = "t3.micro"
    }
    dispatch = {
      name = "dispatch"
      type = "t3.micro"
    }
    mongodb = {
      name = "mongodb"
      type = "t3.micro"
    }
    mysql = {
      name = "mysql"
      type = "t3.micro"
    }
    rabbitmq = {
      name = "rabbitmq"
      type = "t3.micro"
    }

  }
}
