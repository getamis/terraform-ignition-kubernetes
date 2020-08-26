data "ignition_file" "iam_authenticator" {
  filesystem = "root"
  mode       = 420
  path       = "${var.addons_dir_path}/iam-authenticator.yaml"

  content {
    content = templatefile("${path.module}/templates/iam-authenticator.yaml.tpl", {
      image        = "${var.container["repo"]}:${var.container["tag"]}"
      cluster_name = var.cluster_name
      state_path   = var.state_path
    })
  }
}