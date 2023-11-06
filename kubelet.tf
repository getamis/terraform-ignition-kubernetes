module "kubelet" {
  source = "./modules/kubelet"

  kubernetes_version   = var.kubernetes_version
  binaries             = var.binaries
  containers           = local.containers
  service_network_cidr = var.service_network_cidr
  network_plugin       = var.network_plugin
  cloud_provider       = var.cloud_provider
  extra_config         = local.kubelet_config
  extra_flags          = var.kubelet_flags
  feature_gates        = var.feature_gates
  enable_eni_prefix    = var.enable_eni_prefix
  max_pods             = var.max_pods
  log_level            = var.log_level["kubelet"]
}

data "ignition_file" "kubelet_csr_json_tpl" {
  path      = "${local.opt_path}/templates/kubelet-csr.json.tpl"
  mode      = 420
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/certs/kubelet-csr.json.tpl", {
      algo = local.kubelet_cert.algo
      size = local.kubelet_cert.size
    })
  }
}

data "ignition_file" "ca_config_json_tpl" {
  path      = "${local.opt_path}/templates/ca-config.json.tpl"
  mode      = 420
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/certs/ca-config.json.tpl", {
      expiry = local.kubelet_cert.expiry
    })
  }
}
