variable "container" {
  description = "Desired container repo and tag."
  type        = map(string)
  default = {
    repo = "quay.io/amis/aws-pod-identity-webhook"
    tag  = "v0.2.0"
  }
}

variable "addons_dir_path" {
  description = "A path for installing addons."
  type        = string
  default     = "/etc/kubernetes/addons"
}

variable "pki_dir_path" {
  description = "A path for writting PKI."
  type        = string
  default     = "/etc/kubernetes/pki/webhook"
}

variable "webhook_flags" {
  description = "The flags of pod identity webhook. The variables need to follow https://github.com/aws/amazon-eks-pod-identity-webhook/blob/master/main.go. Do not use underline."
  default     = {}
}

variable "tls_cert_ca" {
  description = "TLS certificate authority."
  type        = string
  default     = ""
}

variable "tls_cert" {
  description = "TLS certificate file content."
  type        = string
  default     = ""
}

variable "tls_key" {
  description = "TLS key file content."
  type        = string
  default     = ""
}