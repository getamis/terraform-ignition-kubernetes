data "ignition_file" "iam_auth_cert" {
  filesystem = "root"
  mode       = 420
  path       = "${var.cert_path}/cert.pem"

  content {
    content = var.auth_cert
  }
}

data "ignition_file" "iam_auth_key" {
  filesystem = "root"
  mode       = 420
  path       = "${var.cert_path}/key.pem"

  content {
    content = var.auth_cert_key
  }
}

