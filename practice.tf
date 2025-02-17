provider aws {
region = "eu-west-2"

}

resource aws_vpc "myvpc"{

    cidr_block = "10.0.0.0/16"

}

#variable

variable "myvar" {
    type = string
    default = "Harrys"
  
}

variable "myvar" {
    type = number
    default = 2
  
}
#boolean

variable "myboolean" {
    default = true
  
}

#list

variable "mylist" {
    type = list(number)
    default = [2, 3]
  
}

#map

variable "mymap" {
    type = map
    default = {
        key1 = "value1"
        key2 = "value2"
    }
  
}

#input

variable "input" {
    type = string
    description = "Input description"
  
}

#output

output "name" { #The output contains a value
  value = aws_vpc.myvpc.cidr_block
}

#tuple 

variable "my tuple" {
    type = tuple([ number, string ])
    default = [2, "deux"]
  
}

#An object

variable "myobject" {
    type = object({
      name = "Ball",
      port = list(number)
    })
  
}


#An ec2 instance

resource "aws_instance" "db" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.SG1.name]
    tags = {
        name = "practice_db"
    }
  
}

#Security group

resource "aws_security_group" "SG1" {
    name = "practice_sg1"
    ingress {
        from_port = 80
        to_port = 443
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
    egress {
        from_port = 80
        to_port = 443
        protocol = "TCP"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

#Dynamic security groups

variable "ingressrule" {
  type = list(number)
  default = [80, 443]
}

variable "egressrule" {
  type = list(number)
  default = [80, 443]
}

resource "aws_security_group" "SG2" {
    name = "practice_sg2"
    
    dynamic "ingress" {
    iterator = port
    for_each = var.ingressrule 
    content {
    from_port = value.port
    to_port = value.port
    protocol = "TCP"
    cidr_blocks = [ "0.0.0.0/0" ]
    }
    }
    dynamic "egress" {
    iterator = port
    for_each = var.ingressrule 
    content {
    from_port = value.port
    to_port = value.port
    protocol = "TCP"
    cidr_blocks = [ "0.0.0.0/0" ]
    }
    }
}

#EIP

resource "aws_eip" "EIP" {
    instance = [aws_instance.db.id]
  
}

#Output private_IP DB

output "private_IP" {
    value = aws_eip.EIP.private_ip
  
}

#Output public_IP DB

output "public_IP" {
  value = aws_eip.EIP.public_ip
}

#A MODULE is simply a folder with terraform code inside


#Reference outputs in a module