provider "aws" {
    region = "eu-west-3"
  
}

variable "number_of_servers" {
  type = number
  
}
resource "aws_instance" "myec2" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    count = var.number_of_servers # Count enbles terraform to create multiple instances
    tags = {
      Name = "ec2"
    }
  
}