provider "aws" {
  region = "eu-west-3"
}

resource "aws_db_instance" "myRDS" {
    db_name = "myDB" # this the name of our DB that is going to create inside the RDS instance
    allocated_storage = 20
    engine = "mariadb"
    engine_version = "10.2.21"
    username = "Harrys"
    password = "321"
    identifier = "" #it is a unique reference of our DB
    instance_class = "db.t2.micro"
    port = 3306 #3306 is a default port 
    skip_final_snapshot = true #when destroying the rds, skip taking snapshot and just delete
  
}