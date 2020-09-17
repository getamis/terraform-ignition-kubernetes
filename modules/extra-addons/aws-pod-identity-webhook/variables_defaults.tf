locals {
  webhook_flags = merge({
    logtostderr       = true
    annotation-prefix = "k8s.amazonaws.com"
    token-audience    = "sts.amazonaws.com"
  }, var.webhook_flags)
}
