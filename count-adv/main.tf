provider "aws" {
  region = "eu-west-3"
}

module "db" {
    source = "./db"
    dbname = ["mariadb", "mysql", "mssql" ]
}


output "private_ips" {
 value = module.db.PrivateIP 
}