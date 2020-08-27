data "ignition_file" "pod_identity_webhook" {
  filesystem = "root"
  mode       = 420
  path       = "${var.addons_dir_path}/pod-identity-webhook.yaml"

  content {
    content = templatefile("${path.module}/templates/pod-identity-webhook.yaml.tpl", {
      image       = "${var.container["repo"]}:${var.container["tag"]}"
      extra_flags = var.webhook_flags
      ca_bundle   = base64encode(var.webhook_cert_ca)
    })
  }
}
