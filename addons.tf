locals {
  kube_proxy_cm_v1alpha1 = {
    data = {
      "config.conf" = merge(local.kube_proxy_config, {
        apiVersion = "kubeproxy.config.k8s.io/v1alpha1"
        kind       = "KubeProxyConfiguration"
        clientConnection = {
          kubeconfig = "/var/lib/kube-proxy/kubeconfig.conf"
        }
      })
    }
  }
}

data "ignition_file" "kube_proxy" {
  mode      = 420
  path      = "${local.etc_path}/addons/kube-proxy.yaml"
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/addons/kube-proxy.yaml.tpl", {
      image     = "${local.containers["kube_proxy"].repo}:${local.containers["kube_proxy"].tag}"
      log_level = var.log_level["kube_proxy"]
    })
    mime = "text/yaml"
  }
}

data "ignition_file" "kube_proxy_cm" {
  mode      = 420
  path      = "${local.etc_path}/addons/kube-proxy-cm.yaml"
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/addons/kube-proxy-cm.yaml.tpl", {
      endpoint = var.internal_endpoint
      content  = local.kube_proxy_cm_v1alpha1
    })
    mime = "text/yaml"
  }
}

// TODO(kairen): add support for stub-domains 
data "ignition_file" "coredns" {
  mode      = 420
  path      = "${local.etc_path}/addons/coredns.yaml"
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/addons/coredns.yaml.tpl", {
      image                    = "${local.containers["coredns"].repo}:${local.containers["coredns"].tag}"
      replicas                 = local.coredns_config["replicas"]
      cluster_dns_ip           = local.coredns_config["cluster_dns_ip"]
      cluster_domain           = local.coredns_config["cluster_domain"]
      upstream_nameservers     = local.coredns_config["upstream_nameservers"]
      located_on_the_same_host = local.coredns_config["located_on_the_same_host"]
    })
    mime = "text/yaml"
  }
}