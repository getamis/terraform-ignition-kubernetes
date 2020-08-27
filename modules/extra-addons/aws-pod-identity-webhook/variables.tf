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

variable "webhook_flags" {
  description = "The flags of pod identity webhook. The variables need to follow https://github.com/aws/amazon-eks-pod-identity-webhook/blob/master/main.go. Do not use underline."
  default     = {}
}

variable "webhook_cert_ca" {
  description = "The webhook certificate authority."
  type        = string
  default     = ""
}