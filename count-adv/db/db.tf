
variable "dbname" {
    type = list(string)
  
}

resource "aws_instance" "db" {
    ami = "ami-0e6f0c264bdf0c34c"
    instance_type = "t2.micro"
    count = length(var.dbname) #the lenth of the list will be the counting number
    tags = {
      Name = var.dbname[count.index] #the index helps here to display names per number
    }
}


output "PrivateIP" {
  value = [aws_instance.db.*.private_ip]
  # the * is essential here to indicate the ouptut will be displayed using the length of the variable
}