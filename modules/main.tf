provider "aws" {
    region = "eu-west-3"
  
}

module "first_module" {
    source = "./ec2"
    ec2name = "Chosen by the module"
}

#how to output an ID in a module
output "module_output" {
    value = module.first_module.output1 #the word "module" is essential here
}