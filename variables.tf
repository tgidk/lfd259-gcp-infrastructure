variable "public_key" {
  description = "The public key to be used for SSH access to the instances"
  type        = string
  default     = "add-your-public-key-here"
}

variable "username" {
  description = "The username to be used for SSH access to the instances"
  type        = string
  default     = "add-your-login-for-virtual-machines-here"
}