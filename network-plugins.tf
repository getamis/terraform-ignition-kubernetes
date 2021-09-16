data "ignition_file" "systemd_networkd_conf" {
  path      = "/etc/systemd/network/10-aws-vpc-cni.link"
  mode      = 420
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/network-plugins/amazon-vpc/10-aws-vpc-cni.link.tpl", {})
  }
}

data "ignition_file" "network_manager_conf" {
  path      = "/etc/NetworkManager/conf.d/aws-cni.conf"
  mode      = 420
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/network-plugins/amazon-vpc/aws-cni.conf.tpl", {})
  }
}

data "ignition_file" "aws_vpc_cni_yaml" {
  count = var.network_plugin == "amazon-vpc" ? 1 : 0

  mode      = 420
  path      = "${local.etc_path}/addons/aws-k8s-cni.yaml"
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/network-plugins/amazon-vpc/aws-vpc-cni.yaml.tpl", {
      image      = "${local.containers["vpc_cni"].repo}:${local.containers["vpc_cni"].tag}"
      init_image = "${local.containers["vpc_cni_init"].repo}:${local.containers["vpc_cni_init"].tag}"
    })
  }
}

data "ignition_file" "aws_cni_calico_yaml" {
  count = var.enable_calico ? 1 : 0

  mode      = 420
  path      = "${local.etc_path}/addons/calico-cni.yaml"
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/network-plugins/amazon-vpc/calico.yaml.tpl", {
      node_image       = "${local.containers["calico_node"].repo}:${local.containers["calico_node"].tag}"
      typha_image      = "${local.containers["calico_typha"].repo}:${local.containers["calico_typha"].tag}"
      autoscaler_image = "${local.containers["calico_autoscaler"].repo}:${local.containers["calico_autoscaler"].tag}"
    })
  }
}

data "ignition_file" "flannel_yaml" {
  count = var.network_plugin == "flannel" ? 1 : 0

  mode      = 420
  path      = "${local.etc_path}/addons/flannel-cni.yaml"
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/network-plugins/flannel/flannel.yaml.tpl", {
      image        = "${local.containers["flannel_cni"].repo}:${local.containers["flannel_cni"].tag}"
      cluster_cidr = var.pod_network_cidr
    })
  }
}
