variable "kubernetes_version" {
  description = "Desired Kubernetes version."
  type        = string
  default     = "v1.27.7"
}

variable "binaries" {
  description = "Desired binaries(cni_plugin) url and checksum."
  type = map(object({
    source   = string
    checksum = string
  }))
  default = {}
}

variable "containers" {
  description = "Desired containers(kubelet, and so on) repo and tag."
  type = map(object({
    repo = string
    tag  = string
  }))
  default = {}
}

variable "service_network_cidr" {
  description = "This is the virtual IP address that will be assigned to services created on Kubernetes."
  type        = string
  default     = "10.96.0.0/12"
}

variable "network_plugin" {
  description = "Desired network plugin which is use for Kubernetes cluster. e.g. 'flannel', 'amazon-vpc', 'cilium-vxlan'"
  type        = string
  default     = "amazon-vpc"
}

variable "cloud_provider" {
  description = "The cloud provider configuration."
  type        = string
  default     = "aws"
}

variable "extra_config" {
  description = "The extra configuration of kubelet. The variables need to follow https://github.com/kubernetes/kubernetes/blob/master/staging/src/k8s.io/kubelet/config/v1beta1/types.go. Do not use underline."
  type        = map(string)
  default     = {}
}

variable "extra_flags" {
  description = "The extra flags of kubelet. The variables need to follow https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/. Do not use underline."
  type        = map(string)
  default     = {}
}

variable "bootstrap_kubeconfig_content" {
  description = "The content of bootstrap kubeconfig."
  type        = string
  default     = ""
}

// TODO(kairen): add support for setting feature gates.
variable "feature_gates" {
  description = "A set of key=value pairs that describe feature gates for alpha/experimental features."
  type        = map(bool)
  default     = {}
}

variable "enable_eni_prefix" {
  description = "(Optional) assign prefix to AWS EC2 network interface"
  type        = bool
  default     = true
}

variable "max_pods" {
  description = "(Optional) the max pod number in the node when enable eni prefix"
  type        = string
  default     = "110"
}

variable "log_level" {
  description = "(Optional) log level of kubelet, default is 2 (Info)"
  type        = string
  default     = "2"
}