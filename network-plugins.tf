data "ignition_file" "aws_vpc_cni_yaml" {
  count = var.network_plugin == "amazon-vpc" ? 1 : 0

  mode      = 420
  path      = "${local.etc_path}/addons/aws-k8s-cni.yaml"
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/network-plugins/amazon-vpc/aws-vpc-cni.yaml.tpl", {
      # images
      image            = "${local.containers["vpc_cni"].repo}:${local.containers["vpc_cni"].tag}"
      init_image       = "${local.containers["vpc_cni_init"].repo}:${local.containers["vpc_cni_init"].tag}"
      node_agent_image = "${local.containers["aws_network_policy_agent"].repo}:${local.containers["aws_network_policy_agent"].tag}"
      # vpc cni config
      annotate_pod_ip   = var.annotate_pod_ip
      cni_version       = local.containers["vpc_cni"].tag
      cluster_endpoint  = var.internal_endpoint
      enable_eni_prefix = var.enable_eni_prefix
      external_snat     = var.external_snat
      log_level         = var.log_level["aws_vpc_cni"]
    })
    mime = "text/yaml"
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
    mime = "text/yaml"
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
    mime = "text/yaml"
  }
}

data "ignition_file" "cilium_vxlan_yaml" {
  count = var.network_plugin == "cilium-vxlan" ? 1 : 0

  mode      = 420
  path      = "${local.etc_path}/addons/cilium-cni.yaml"
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/network-plugins/cilium/cilium-vxlan.yaml.tpl", {
      agent_repo        = local.containers["cilium_agent"].repo
      agent_tag         = local.containers["cilium_agent"].tag
      operator_repo     = local.containers["cilium_operator"].repo
      operator_tag      = local.containers["cilium_operator"].tag
      hubble_relay_repo = local.containers["hubble_relay"].repo
      hubble_relay_tag  = local.containers["hubble_relay"].tag
      certgen_repo      = local.containers["cilium_certgen"].repo
      certgen_tag       = local.containers["cilium_certgen"].tag
      cluster_cidr      = var.pod_network_cidr
      cluster_mask_size = var.node_cidr_mask_size
      apiserver_host    = trimprefix(var.internal_endpoint, "https://")
      apiserver_port    = "443"
      debug             = var.log_level["cilium_cni"] == "DEBUG" ? true : false
    })
    mime = "text/yaml"
  }
}
