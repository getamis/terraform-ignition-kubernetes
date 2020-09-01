locals {
  flags = merge(local.webhook_flags,
    var.tls_cert != "" && var.tls_key != "" ? {
      in-cluster = false
      tls-cert   = "/etc/webhook/certs/tls.crt"
      tls-key    = "/etc/webhook/certs/tls.key"
    } : {}
  )
}

data "ignition_file" "pod_identity_webhook" {
  filesystem = "root"
  mode       = 420
  path       = "${var.addons_dir_path}/pod-identity-webhook.yaml"

  content {
    content = templatefile("${path.module}/templates/pod-identity-webhook.yaml.tpl", {
      image     = "${var.container["repo"]}:${var.container["tag"]}"
      flags     = local.flags
      ca_bundle = base64encode(var.tls_cert_ca)
      pki_path  = var.pki_dir_path
      tls_cert  = var.tls_cert
      tls_key   = var.tls_key
    })
  }
}
