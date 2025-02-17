
variable "dbname" {
    type = string
  
}

resource "aws_instance" "db" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    tags = {
      Name = var.dbname
    }
}


output "PrivateIP" {
  value = aws_instance.db.private_ip
}