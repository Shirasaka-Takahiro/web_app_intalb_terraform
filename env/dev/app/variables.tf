##Access key
variable "access_key" {
  description = "Access key"
  type        = string
}

##Secret Key
variable "secret_key" {
  description = "Secret Key"
  type        = string
}

##General Config
variable "general_config" {
  type = map(any)
  default = {
    project = "example"
    env     = "dev"
    service = "app"
  }
}

##Regions
variable "regions" {
  default = {
    tokyo = "ap-northeast-1"
  }
}

##Domain name
variable "domain_name" {
  description = "Domain Name"
  type        = list(string)
}