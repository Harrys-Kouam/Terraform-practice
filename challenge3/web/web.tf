variable "webname" {
    type = string
  
}

resource "aws_instance" "web" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    tags = {
      Name = var.webname
    }
    security_groups = [aws_security_group.challenge2_security.name]
    user_data = file("server-script.sh")
}

resource "aws_eip" "webid" {
  instance = aws_instance.web.id
}


output "PublicIP" {
  value = aws_eip.webid.public_ip
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