data "ignition_file" "tls_cert" {
  count = var.tls_cert != "" ? 1 : 0

  filesystem = "root"
  mode       = 420
  path       = "${var.pki_dir_path}/tls.crt"

  content {
    content = var.tls_cert
  }
}

data "ignition_file" "tls_key" {
  count = var.tls_key != "" ? 1 : 0

  filesystem = "root"
  mode       = 420
  path       = "${var.pki_dir_path}/tls.key"

  content {
    content = var.tls_key
  }
}
