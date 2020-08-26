variable "cluster_name" {
  description = "Kubernetes cluster name."
  type        = string
  default     = "kubernetes"
}

variable "container" {
  description = "Desired container repo and tag."
  type        = map(string)
  default = {
    repo = "quay.io/amis/aws-iam-authenticator"
    tag  = "v0.5.1"
  }
}

variable "addons_dir_path" {
  description = "A path for installing addons."
  type        = string
  default     = "/etc/kubernetes/addons"
}

variable "state_path" {
  description = "Persisted TLS certificate and keys."
  type        = string
  default     = "/var/aws-iam-authenticator"
}