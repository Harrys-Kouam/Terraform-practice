provider "aws" {
    region = "eu-west-3"
  
}

resource "aws_instance" "myec2" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    tags = {
      Name = "fistec2"
    }
  
}