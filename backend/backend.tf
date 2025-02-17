#This codes transfers the state file into an S3 bucket pre-created by using the management console

terraform {  #it tells terraform to makes some configuration changes
#this is to tell terraform to store the staefile somewhere else
 #shows it is going to store the state file in the s3 storage
  backend "s3"  { 
  key = "terraform/tf.tfsate"
  bucket = "dk-remote-backend-2020"
  region = "eu-west-3"
  access_key = "access_key"
  secret_key = "secret_key"
  }
}   
