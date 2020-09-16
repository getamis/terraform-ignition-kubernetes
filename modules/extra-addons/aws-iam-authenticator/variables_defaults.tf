locals {
  extra_flags = merge({
    kubeconfig-pregenerated = true
    backend-mode            = "CRD"
  }, var.extra_flags)
}
