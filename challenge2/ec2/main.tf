provider "aws" {
    region = "eu-west-3"
  
}

resource "aws_instance" "db" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    tags = {
      Name = "DB_server"
    }
}

output "PrivateIP" {
  value = aws_instance.db.private_ip
}

resource "aws_instance" "web" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    tags = {
      Name = "web_server"
    }
    security_groups = [aws_security_group.challenge2_security.name]
    user_data = file("server-script.sh")
}

resource "aws_eip" "webip" {
  instance = aws_instance.web.id
}


output "PublicIP" {
  value = aws_eip.webip.public_ip
}


variable "ingressrule" {
  type = list(number)
  default = [80, 443]
}


variable "egressrule" {
  type = list(number)
  default = [80, 443]
}


resource "aws_security_group" "challenge2_security" {
  name = "HTTP and HTTPs"


  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrule
    content {
    from_port= port.value
    to_port = port.value
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  dynamic "egress" {
    iterator = port
    for_each = var.egressrule
    content {
    from_port= port.value
    to_port = port.value
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
}