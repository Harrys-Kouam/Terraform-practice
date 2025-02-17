provider "aws" {
    region = "eu-west-2"
}

module "ec2" {
    source = "./ec2" #directs the source to the file ec2
    # count = 3 #indicates the creation of 3 ec2, but this is the old way of doing it
    for_each = toset(["Harrys", "Stephie", "Ilona"])
        
}