data "ignition_file" "pod_identity_webhook" {
  mode      = 420
  path      = "${var.addons_dir_path}/pod-identity-webhook.yaml"
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/pod-identity-webhook.yaml.tpl", {
      image                 = "${var.container["repo"]}:${var.container["tag"]}"
      service_name          = var.service_name
      namespace             = var.namespace
      replicas              = var.replicas
      flags                 = local.webhook_flags
      ca_bundle             = base64encode(var.mutating_webhook_ca_bundle)
      tls_crt               = base64encode(var.tls_cert)
      tls_key               = base64encode(var.tls_key)
      located_control_plane = var.located_control_plane
    })
    mime = "text/yaml"
  }
}
