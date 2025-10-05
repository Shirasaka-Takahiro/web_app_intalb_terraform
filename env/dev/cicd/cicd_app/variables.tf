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

##Region
variable "region" {
  description = "Default AWS Region"
  type        = string
  default     = "ap-northeast-1"
}

variable "full_repositroy_id" {
  description = "GitHub full repository ID. USername/RepositoryName"
  type        = string
  default     = ""
}

##Codepipeline
variable "branch_name" {
  description = "Codepipeline Github branch name"
  type        = string
  default     = ""
}