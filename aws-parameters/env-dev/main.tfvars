parameters = [
  { name = "dev.frontend.catalogue_url", value = "http://catalogue-dev.devopsb71.live:8080/", type = "String" },
  { name = "dev.frontend.user_url", value = "http://user-dev.devopsb71.live:8080/", type = "String" },
  { name = "dev.frontend.cart_url", value = "http://cart-dev.devopsb71.live:8080/", type = "String" },
  { name = "dev.frontend.shipping_url", value = "http://shipping-dev.devopsb71.live:8080/", type = "String" },
  { name = "dev.frontend.payment_url", value = "http://payment-dev.devopsb71.live:8080/", type = "String" },
  { name = "dev.user.mongo", value = "true", type = "String" },
  { name = "dev.user.redis_host", value = "redis-dev.devopsb71.live", type = "String" },
  { name = "dev.user.mongo_url", value = "mongodb://mongodb-dev.devopsb71.live:27017/catalogue", type = "String" },
  { name = "dev.shipping.cart_endpoint", value = "cart-dev.devopsb71.live:8080", type = "String" },
  { name = "dev.shipping.db_host", value = "mysql-dev.devopsb71.live", type = "String" },
  { name = "dev.payment.cart_host", value = "cart-dev.devopsb71.live", type = "String" },
  { name = "dev.payment.cart_port", value = "8080", type = "String" },
  { name = "dev.payment.user_host", value = "user-dev.devopsb71.live", type = "String" },
  { name = "dev.payment.user_port", value = "8080", type = "String" },
  { name = "dev.payment.amqp_host", value = "rabbitmq-dev.devopsb71.live", type = "String" },
  { name = "dev.catalogue.mongo", value = "true", type = "String" },
  { name = "dev.catalogue.mongo_url", value = "mongodb://mongodb-dev.devopsb71.live:27017/users", type = "String" },
  { name = "dev.cart.redis_host", value = "redis-dev.devopsb71.live", type = "String" },
  { name = "dev.cart.catalogue_host", value = "catalogue-dev.devopsb71.live", type = "String" },
  { name = "dev.cart.catalogue_port", value = "8080", type = "String" },
  { name = "dev.dispatch.amqp_host", value = "rabbitmq-dev.devopsb71.live", type = "String" }
]

## This is not best practice and not followed in companies, passwords should not keep in git repos and manual is best practice
secrets = [
  {name = "dev.mysql.password", value = "RoboShop@1", type = "SecureString"},
  {name = "dev.payment.amqp_user", value = "roboshop", type = "SecureString"},
  {name = "dev.payment.amqp_pass", value = "roboshop123", type = "SecureString"},
  {name = "dev.rabbitmq.amqp_user", value = "roboshop", type = "SecureString"},
  {name = "dev.rabbitmq.amqp_pass", value = "roboshop123", type = "SecureString"},
  {name = "dev.docdb.user", value = "admin1", type = "SecureString"},
  {name = "dev.docdb.pass", value = "roboshop1", type = "SecureString"}
]

