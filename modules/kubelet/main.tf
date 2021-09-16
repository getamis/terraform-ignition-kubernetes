locals {
  bin_path = "/usr/local/bin"
  etc_path = "/etc/kubernetes"
  opt_path = "/opt/kubernetes"
  
  log_path = "/var/log/kubernetes"

  kubelet_config_v1beta1 = merge(local.kubelet_config, {
    apiVersion = "kubelet.config.k8s.io/v1beta1"
    kind       = "KubeletConfiguration"

    authentication = {
      x509 = {
        clientCAFile = "${local.etc_path}/pki/ca.crt"
      }
    }
    staticPodPath = "${local.etc_path}/manifests"
  })

  kubelet_extra_flags = merge(var.extra_flags, {
    pod-infra-container-image = "${local.containers["pause"].repo}:${local.containers["pause"].tag}"
    volume-plugin-dir         = "/var/lib/kubelet/volumeplugins"
  })
}



data "ignition_file" "kubelet_tgz" {
  path      = "/opt/kubelet/node.tar.gz"
  mode      = 500
  overwrite = true


  source {
    source       = local.binaries["kubelet"].source
    verification = local.binaries["kubelet"].checksum
  }
}

data "ignition_file" "cni_plugin_tgz" {
  path      = "/opt/cni/cni-plugins-linux.tgz"
  mode      = 500
  overwrite = true


  source {
    source       = local.binaries["cni_plugin"].source
    verification = local.binaries["cni_plugin"].checksum
  }
}

data "ignition_file" "kubernetes_env" {
  path      = "/etc/default/kubernetes.env"
  mode      = 420
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/services/kubernetes.env.tpl", {
      cfssl_image_repo   = local.containers["cfssl"].repo
      cfssl_image_tag    = local.containers["cfssl"].tag
      cloud_provider     = local.cloud_config.provider
      network_plugin     = var.network_plugin
    })
  }
}

data "ignition_file" "init_configs_sh" {
  path      = "${local.bin_path}/kubeinit-configs.sh"
  mode      = 500
  overwrite = true


  content {
    content = file("${path.module}/files/scripts/kubeinit-configs.sh")
  }
}

data "ignition_file" "get_host_info_sh" {
  path      = "${local.bin_path}/get-host-info.sh"
  mode      = 500
  overwrite = true


  content {
    content = file("${path.module}/files/scripts/get-host-info.sh")
  }
}

data "ignition_file" "kubelet_wrapper_sh" {
  path      = "${local.bin_path}/kubelet-wrapper.sh"
  mode      = 500
  overwrite = true


  content {
    content = file("${path.module}/files/scripts/kubelet-wrapper.sh")
  }
}

data "ignition_file" "kubelet_config_tpl" {
  path      = "${local.opt_path}/templates/config.yaml.tpl"
  mode      = 420
  overwrite = true


  content {
    content = templatefile("${path.module}/templates/configs/kubelet.yaml.tpl", {
      content = local.kubelet_config_v1beta1
    })
  }
}

data "ignition_file" "bootstrap_kubeconfig" {
  path      = "${local.etc_path}/bootstrap-kubelet.conf"
  mode      = 420
  overwrite = true


  content {
    content = var.bootstrap_kubeconfig_content
  }
}

data "ignition_file" "kubelet_env" {
  path      = "/var/lib/kubelet/kubelet-flags.env"
  mode      = 420
  overwrite = true


  content {
    content = templatefile("${path.module}/templates/services/kubelet-flags.env.tpl", {
      kubelet_cloud_provider_flag    = local.cloud_config.provider != "" ? "--cloud-provider=${local.cloud_config.provider}" : ""
      kubelet_cloud_config_path_flag = local.cloud_config.path != "" ? "--cloud-config=${local.cloud_config.path}" : ""
      extra_flags                    = local.kubelet_extra_flags
    })
  }
}

data "ignition_systemd_unit" "kubelet" {
  name    = "kubelet.service"
  enabled = true
  content = templatefile("${path.module}/templates/services/kubelet.service.tpl", {
    kubeconfig           = "${local.etc_path}/kubelet.conf"
    bootstrap_kubeconfig = "${local.etc_path}/bootstrap-kubelet.conf"    
  })
}

data "ignition_systemd_unit" "kubeinit_configs" {
  name    = "kubeinit-configs.service"
  enabled = true
  content = templatefile("${path.module}/templates/services/kubeinit-configs.service.tpl", {})
}
