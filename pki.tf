data "ignition_file" "kubernetes_ca_cert" {
  mode      = 420
  path      = "${local.etc_path}/pki/ca.crt"
  overwrite = true

  content {
    content = var.certs["ca_cert"]
  }
}

data "ignition_file" "kubernetes_ca_key" {
  mode      = 420
  path      = "${local.etc_path}/pki/ca.key"
  overwrite = true

  content {
    content = var.certs["ca_key"]
  }
}

data "ignition_file" "front_proxy_ca_cert" {
  mode      = 420
  path      = "${local.etc_path}/pki/front-proxy-ca.crt"
  overwrite = true

  content {
    content = var.certs["front_proxy_ca_cert"]
  }
}

data "ignition_file" "front_proxy_ca_key" {
  mode      = 420
  path      = "${local.etc_path}/pki/front-proxy-ca.key"
  overwrite = true

  content {
    content = var.certs["front_proxy_ca_key"]
  }
}

data "ignition_file" "apiserver_cert" {
  mode      = 420
  path      = "${local.etc_path}/pki/apiserver.crt"
  overwrite = true

  content {
    content = var.certs["apiserver_cert"]
  }
}

data "ignition_file" "apiserver_key" {
  mode      = 420
  path      = "${local.etc_path}/pki/apiserver.key"
  overwrite = true

  content {
    content = var.certs["apiserver_key"]
  }
}

data "ignition_file" "apiserver_kubelet_client_cert" {
  mode      = 420
  path      = "${local.etc_path}/pki/apiserver-kubelet-client.crt"
  overwrite = true

  content {
    content = var.certs["apiserver_kubelet_client_cert"]
  }
}

data "ignition_file" "apiserver_kubelet_client_key" {
  mode      = 420
  path      = "${local.etc_path}/pki/apiserver-kubelet-client.key"
  overwrite = true

  content {
    content = var.certs["apiserver_kubelet_client_key"]
  }
}

data "ignition_file" "apiserver_etcd_client_cert" {
  mode      = 420
  path      = "${local.etc_path}/pki/apiserver-etcd-client.crt"
  overwrite = true

  content {
    content = var.certs["apiserver_etcd_client_cert"]
  }
}

data "ignition_file" "apiserver_etcd_client_key" {
  mode      = 420
  path      = "${local.etc_path}/pki/apiserver-etcd-client.key"
  overwrite = true

  content {
    content = var.certs["apiserver_etcd_client_key"]
  }
}

data "ignition_file" "front_proxy_client_cert" {
  mode      = 420
  path      = "${local.etc_path}/pki/front-proxy-client.crt"
  overwrite = true

  content {
    content = var.certs["front_proxy_client_cert"]
  }
}

data "ignition_file" "front_proxy_client_key" {
  mode      = 420
  path      = "${local.etc_path}/pki/front-proxy-client.key"
  overwrite = true

  content {
    content = var.certs["front_proxy_client_key"]
  }
}

data "ignition_file" "service_account_public_key" {
  mode      = 420
  path      = "${local.etc_path}/pki/sa.pub"
  overwrite = true

  content {
    content = var.certs["sa_pub"]
  }
}

data "ignition_file" "service_account_private_key" {
  mode      = 420
  path      = "${local.etc_path}/pki/sa.key"
  overwrite = true

  content {
    content = var.certs["sa_key"]
  }
}

data "ignition_file" "etcd_ca_cert" {
  mode      = 420
  path      = "${local.etc_path}/pki/etcd/ca.crt"
  overwrite = true

  content {
    content = var.certs["etcd_ca_cert"]
  }
}
