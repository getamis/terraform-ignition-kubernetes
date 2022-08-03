data "ignition_file" "iam_authenticator" {
  mode       = 420
  path       = "${var.addons_dir_path}/iam-authenticator.yaml"

  content {
    content = templatefile("${path.module}/templates/iam-authenticator.yaml.tpl", {
      image               = "${var.container["repo"]}:${var.container["tag"]}"
      cluster_name        = var.cluster_name
      cert_path           = var.pki_dir_path
      kubeconfig_dir_path = var.kubeconfig_dir_path
      flags               = local.extra_flags
    })
    mime = "text/yaml"
  }
}

data "ignition_file" "kubeconfig" {
  mode       = 420
  path       = "${pathexpand(var.kubeconfig_dir_path)}/kubeconfig"

  content {
    content = templatefile("${path.module}/templates/kubeconfig.tpl", {
      ca          = base64encode(var.auth_ca_cert)
      server_port = var.server_port
    })
  }
}
