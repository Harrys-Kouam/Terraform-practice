provider "aws" {
    region = "eu-west-3"
  
}

module "db_module" {

  source = "./db"
  dbname = "db_module"
}

output "output_db_privateIP" {

  value = module.db_module.PrivateIP
  
}