provider "aws" {
    region = "eu-west-3"
  
}

resource "aws_instance" "myec2" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic]
    tags = {
      Name = "fist_ec2"
    }

}

resource "aws_security_group" "webtraffic" {
  name = "allow HTTP"
  
  ingress { #this is for the traffic coming in
    from_port = 443  #we create a range of ports with a from_port and a to_port
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"] #indicates it can allow all the traffic
  }

  egress { #the security_groups are stateful, which means all the traffic that came in 
  #by a port can our by the same port without having to configure it. 
  #This is why on egress we find the same config as on ingress
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

  }
}