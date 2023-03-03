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
      password = "RoboShop@1"
    }
    payment = {
      name = "payment"
      type = "t3.micro"
      password = "roboshop123"
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
      password = "RoboShop@1"
    }
    rabbitmq = {
      name = "rabbitmq"
      type = "t3.micro"
      password = "roboshop123"
    }

  }
}
