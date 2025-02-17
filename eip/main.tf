#HERE WE WANT TO ATTACH AN IP AD. ON AN EC2 INSTANCE

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

resource "aws_eip" "elasticeip" {

  instance = aws_instance.myec2.id #this is to get the instance id

  
}

output "EIP" {
  value = aws_eip.elasticeip.public_ip
  
}