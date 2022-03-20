data "ignition_file" "iam_auth_cert" {
  mode      = 420
  path      = "${var.pki_dir_path}/cert.pem"
  overwrite = true

  content {
    content = var.auth_cert
  }
}

data "ignition_file" "iam_auth_key" {
  mode      = 420
  path      = "${var.pki_dir_path}/key.pem"
  overwrite = true

  content {
    content = var.auth_cert_key
  }
}

