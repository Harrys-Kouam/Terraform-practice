provider "aws" {
    region = "eu-west-3"
  
}

resource  "aws_vpc" "challengevpc" {#a vpc contains a cidr block
    cidr_block =  "192.168.0.0/24"  #don't forget the quotes
    tags = {                        #tags can be used to create 
        Name = "TerraformVPC"
    }
}


