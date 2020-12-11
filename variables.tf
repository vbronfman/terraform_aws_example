variable "profile" {
  default = "terraform_iam_user"
}

variable "ansible_user" {
  default = "ubuntu"
} 

variable "instance_count" {
  default = "1"
}

variable "public_key" {
  default = "MyKeyPair.pub"
}

variable "private_key" {
  default = "MyKeyPair.pem"
}

variable "ami" {
  default = "ami-00f44084952227ef0"
}