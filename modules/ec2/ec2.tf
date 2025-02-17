variable "ec2name" {
    type = string
  
}


resource "aws_instance" "myec2" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    tags = {
      Name = var.ec2name
    }
  
}

output "output1" {
    value = aws_instance.myec2.id
  
}

