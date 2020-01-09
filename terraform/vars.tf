variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "us-east-2"
}

variable "AWS_SGID_OPT" {
  type = list(string)
  default = ["sg-03515804f399b875c", "sg-0cd31994fd30df187"]
}

variable "AWS_SGID_K8S" {
  type = list(string)
  default = ["sg-03515804f399b875c", "sg-00fb7b3bb8387c0d8"]
}

variable "VAGRANTBOX_SSH_PUBKEY" {}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-09f9d773751b9d606"
    us-east-2 = "ami-0891395d749676c2e"
    us-west-1 = "ami-0c0e5a396959508b0"
  }
}

variable "AWS_ROUTE53_ZONEID_K8S" {
  type = string
  default = "ZLBEG2VCIDIJQ"
}

variable "INSTANCE_LIST" {
  type = list(string)
  default = ["terra01", "terra02", "terra03"]
} 
