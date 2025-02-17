provider "aws" {
    region =  "eu-west-2"

}
#A variable always has the same format, the name - { the type, default which represents the default value}
variable "myvpc" {
type = string
default = "myvpc"
}

variable "myvar" {

type = number
default = 14

}

variable "myboolean" {

    default = true
}

variable "mylist" {

    type = list(string)
    default = ["value1", "value2"]
}

variable "mymap" {

    type = map 
    default = {
        key1 = "value1"
        key2 = "value2"
    }
}

variable "inputname" { #the vpc input has a description

    type = string #here the type tells terraform what to expect when inputing this variable
    description = "Give me my moneyyyy" #this is the description that will be displayed when running "terraform plan"
}
resource "aws_vpc" "myvpc" {

    cidr_block = "10.0.0.0/16"

    tags = {
        Name = var.inputname }
     #   Name = var.myvpc #to set a name for the vpc as a variable
     #   List1 = var.mylist[0] # this is how we access value of the list
     #   Map1 = var.mymap["key1"] #for maps, we specify the name of the key


} 

output "ip_ad" {
  value = aws_vpc.myvpc.cidr_block
}

variable "mytuple" { #it is a way to structure multiple data type
    type = tuple([ string, number, string ])
    default = ["yo", 3, "gars"]
}

variable "myobject" {
    type = object({name = string, port = list(number)})
    default =  {
        name = "Harrys"
        port = [14, 11]
    }
}