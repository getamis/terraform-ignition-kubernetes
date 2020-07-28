locals {
  etc_path = "/etc/kubernetes"
  opt_path = "/opt/kubernetes"
  log_path = "/var/log/kubernetes"
}

data "ignition_file" "init_addons_sh" {
  path       = "${local.opt_path}/bin/init-addons"
  filesystem = "root"
  mode       = 500

  content {
    content = file("${path.module}/scripts/init-addons.sh")
  }
}

data "ignition_systemd_unit" "kubeinit_addons" {
  name    = "kubeinit-addons.service"
  enabled = true
  content = templatefile("${path.module}/templates/services/kubeinit-addons.service.tpl", {
    path = "${local.etc_path}/addons"
  })
}