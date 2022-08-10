locals {
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
    logtostderr               = "false"
    log-dir                   = "/var/log/kubelet"
    log-file-max-size         = "128"
  })
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

data "ignition_file" "envsubst" {
  path      = "/opt/bin/envsubst"
  mode      = 500
  overwrite = true

  source {
    source       = local.binaries["envsubst"].source
    verification = local.binaries["envsubst"].checksum
  }
}

data "ignition_file" "kubernetes_env" {
  path      = "/etc/default/kubernetes.env"
  mode      = 420
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/services/kubernetes.env.tpl", {
      kubelet_image_repo = local.containers["kubelet"].repo
      kubelet_image_tag  = local.containers["kubelet"].tag
      kubectl_image_repo = local.containers["kubectl"].repo
      kubectl_image_tag  = local.containers["kubectl"].tag
      cfssl_image_repo   = local.containers["cfssl"].repo
      cfssl_image_tag    = local.containers["cfssl"].tag
      cloud_provider     = local.cloud_config.provider
      network_plugin     = var.network_plugin
    })
  }
}

data "ignition_file" "init_configs_sh" {
  path      = "${local.opt_path}/bin/init-configs"
  mode      = 500
  overwrite = true

  content {
    content = file("${path.module}/files/scripts/init-configs.sh")
  }
}

data "ignition_file" "get_host_info_sh" {
  path      = "${local.opt_path}/bin/get-host-info.sh"
  mode      = 500
  overwrite = true

  content {
    content = file("${path.module}/files/scripts/get-host-info.sh")
  }
}

data "ignition_file" "node_shutdown_sh" {
  path      = "${local.opt_path}/bin/node-shutdown"
  mode      = 500
  overwrite = true

  content {
    content = file("${path.module}/files/scripts/node-shutdown.sh")
  }
}

data "ignition_file" "kubelet_wrapper_sh" {
  path      = "${local.opt_path}/bin/kubelet-wrapper"
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
    mime = "text/yaml"
  }
}

data "ignition_file" "bootstrap_kubeconfig" {
  count = var.bootstrap_kubeconfig_content != "" ? 1 : 0

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

data "ignition_file" "systemd_drop_in_kubelet_conf" {
  path      = "/etc/systemd/system/kubelet.service.d/10-kubelet.conf"
  mode      = 420
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/services/10-kubelet.conf.tpl", {
      kubeconfig           = "${local.etc_path}/kubelet.conf"
      bootstrap_kubeconfig = "${local.etc_path}/bootstrap-kubelet.conf"
    })
  }
}

data "ignition_file" "logind_kubelet_conf" {
  path      = "/etc/systemd/logind.conf.d/99-kubelet.conf"
  mode      = 420
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/services/logind-99-kubelet.conf.tpl", {})
  }
}

data "ignition_systemd_unit" "kubelet" {
  name    = "kubelet.service"
  enabled = true
  content = templatefile("${path.module}/templates/services/kubelet.service.tpl", {})
}

data "ignition_systemd_unit" "kubeinit_configs" {
  name    = "kubeinit-configs.service"
  enabled = true
  content = templatefile("${path.module}/templates/services/kubeinit-configs.service.tpl", {})
}

data "ignition_systemd_unit" "kubenode_shutdown" {
  name    = "kubenode-shutdown.service"
  enabled = true
  content = templatefile("${path.module}/templates/services/kubenode-shutdown.service.tpl", {})
}