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
    tag  = "v0.5.5"
  }
}

variable "addons_dir_path" {
  description = "A path for installing addons."
  type        = string
  default     = "/etc/kubernetes/addons"
}

variable "pki_dir_path" {
  description = "Persisted TLS certificate and keys."
  type        = string
  default     = "/etc/kubernetes/pki/aws-iam-authenticator"
}

variable "server_port" {
  description = "Localhost port where the server will serve the /authenticate endpoint"
  type        = number
  default     = 21362
}

variable "kubeconfig_dir_path" {
  description = "A path for using iam aws authenticator to authenticate to a Kubernetes cluster."
  type        = string
  default     = "/etc/kubernetes/config/aws-iam-authenticator"
}

variable "auth_ca_cert" {
  description = "Certificate for verifying the AWS iam authenticator webhook"
  type        = string
}

variable "auth_cert" {
  description = "AWS iam authenticator webhook tls cert"
  type        = string
}

variable "auth_cert_key" {
  description = "AWS iam authenticator webhook tls cert key"
  type        = string
}

variable "extra_flags" {
  description = "The extra-flags of IAM Authenticator. The variables need to follow https://github.com/kubernetes-sigs/aws-iam-authenticator/tree/master/cmd/aws-iam-authenticator. Do not use underline."
  default     = {}
}