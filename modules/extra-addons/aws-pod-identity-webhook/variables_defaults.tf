locals {
  webhook_flags = merge({
    in-cluster        = false
    namespace         = var.namespace
    service-name      = var.service_name
    annotation-prefix = "k8s.amazonaws.com"
    token-audience    = "sts.amazonaws.com"
    logtostderr       = true
  }, var.webhook_flags)
}