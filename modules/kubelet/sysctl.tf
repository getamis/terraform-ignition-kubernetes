data "ignition_file" "sysctl_k8s_conf" {
  path      = "/etc/sysctl.d/k8s.conf"
  mode      = 420
  overwrite = true

  content {
    content = file("${path.module}/files/sysctl.d/k8s.conf")
  }
}

data "ignition_file" "sysctl_max_user_watches_conf" {
  path      = "/etc/sysctl.d/max-user-watches.conf"
  mode      = 420
  overwrite = true

  content {
    content = file("${path.module}/files/sysctl.d/max-user-watches.conf")
  }
}

data "ignition_file" "system_accounting_conf" {
  path      = "/etc/systemd/system.conf.d/accounting.conf"
  mode      = 420
  overwrite = true

  content {
    content = file("${path.module}/files/system.conf.d/accounting.conf")
  }
}