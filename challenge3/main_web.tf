

module "web_module" {
    source = "./web"
    webname = "module_web"
}

output "module_web_output_publicIP" {
  value = module.web_module.PublicIP
}

#output "module_web_output_ID" {
#    value = module.web_module.aws_eip.webid.id
  
#}

