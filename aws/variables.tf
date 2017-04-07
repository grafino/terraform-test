variable "key_name" {
  description = "The name of the aws key"
  default     = "grafino_pub"
}

variable "public_key_path" {
  description = "Path to the SSH public key to be used for authentication"
  default     = "~/.ssh/id_rsa.pub"
}
