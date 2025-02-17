provider "aws" {
    region = "eu-west-3"
  
}

resource "aws_instance" "db" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    tags = {
      Name = "db_ec2"
    }
  
}


resource "aws_instance" "web" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    tags = {
      Name = "web_ec2"
    }
#the dependency here is used to tell terraform to create the db server first and the web server second
#We do that by coding that the web server depends on the db server
    depends_on = [ aws_instance.db ] 
}

#DATA SOURCES send API resquests to AWS to obtain informations

data "aws_instance" "dbsearch" {
  filter  {
    name = "tag:Name"
    values = ["db_ec2"]
  }
  
}

output "dbservers" {
  value = data.aws_instance.dbsearch.availability_zone
}