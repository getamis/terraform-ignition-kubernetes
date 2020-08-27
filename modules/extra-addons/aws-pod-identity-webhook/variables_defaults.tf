locals {
  webhook_flags = merge({
    in-cluster        = true
    logtostderr       = true
    namespace         = "kube-system"
    service-name      = "pod-identity-webhook"
    tls-secret        = "pod-identity-webhook"
    annotation-prefix = "k8s.amazonaws.com"
    token-audience    = "sts.amazonaws.com"
  }, var.webhook_flags)
}
