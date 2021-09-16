data "ignition_file" "metrics_server_components" {
  mode      = 420
  path      = "${var.addons_dir_path}/metrics-server.yaml"
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/components.yaml.tpl", {
      image       = "${var.container["repo"]}:${var.container["tag"]}"
      secure_port = var.secure_port
    })
  }
}