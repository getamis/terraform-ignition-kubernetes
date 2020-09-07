data "ignition_file" "tls_cert" {
  filesystem = "root"
  mode       = 420
  path       = "${var.pki_dir_path}/tls.crt"

  content {
    content = var.tls_cert
  }
}

data "ignition_file" "tls_key" {
  filesystem = "root"
  mode       = 420
  path       = "${var.pki_dir_path}/tls.key"

  content {
    content = var.tls_key
  }
}
