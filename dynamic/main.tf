provider "aws" {
    region = "eu-west-3"
  
}

#this how to create DYNAMIC BLOCKS to be used to create multiple security_groups
variable "ingressrules" {
  type = list(number)
  default = [443, 80]
  
}

variable "egressrules" {
  type = list(number)
  default = [443, 80, 53, 8080, 25]
  
}

resource "aws_instance" "myec2" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]
    tags = {
      Name = "fist_ec2"
    }

}

resource "aws_security_group" "webtraffic" {
  name = "allow HTTP"
  
  dynamic "ingress" { #this is for the traffic coming in
    iterator = port #we need an iterator to iterate in the loop
    for_each = var.ingressrules #we need a for_each loop tjhat iterates in the variable ingress
    content { 
    from_port = port.value  #we create a range of ports with a from_port and a to_port
    to_port = port.value
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"] #indicates it can allow all the traffic
  }
  }
  dynamic "egress" { #this is for the traffic going out
    iterator = port #we need an iterator to iterate in the loop
    for_each = var.egressrules #we need a for_each loop 
    content { 
    from_port = port.value  #we create a range of ports with a from_port and a to_port
    to_port = port.value
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"] #indicates it can allow all the traffic

  }
}
}