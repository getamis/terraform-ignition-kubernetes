locals {
  binaries = merge({
    cni_plugin = {
      source   = "https://github.com/containernetworking/plugins/releases/download/v0.9.1/cni-plugins-linux-amd64-v0.9.1.tgz"
      checksum = "sha512-b5a59660053a5f1a33b5dd5624d9ed61864482d9dc8e5b79c9b3afc3d6f62c9830e1c30f9ccba6ee76f5fb1ff0504e58984420cc0680b26cb643f1cb07afbd1c"
    }
  }, var.binaries)

  containers = merge({
    kubelet = {
      repo = "quay.io/amis/kubelet"
      tag  = var.kubernetes_version
    }
    // Included kubectl tool, See https://github.com/getamis/kubelet for more information.
    kubectl = {
      repo = "quay.io/amis/kubelet"
      tag  = var.kubernetes_version
    }
    pause = {
      repo = "k8s.gcr.io/pause"
      tag  = "3.2"
    }
    cfssl = {
      repo = "quay.io/amis/cfssl"
      tag  = "v1.4.1"
    }
  }, var.containers)

  cloud_config = merge({
    // The provider for cloud services. Specify empty string for running with no cloud provider.
    provider = "aws"

    // The path to the cloud provider configuration file. Empty string for no configuration file.
    path = ""
  }, var.cloud_config)

  kubelet_config = merge({
    authentication = {
      anonymous = {
        enabled = false
      }

      webhook = {
        cacheTTL = "2m0s"
        enabled  = true
      }
    }

    authorization = {
      mode = "Webhook"
      webhook = {
        cacheAuthorizedTTL   = "5m0s"
        cacheUnauthorizedTTL = "30s"
      }
    }

    clusterDNS         = [cidrhost(var.service_network_cidr, 10)]
    clusterDomain      = "cluster.local"
    healthzBindAddress = "127.0.0.1"
    healthzPort        = 0
    readOnlyPort       = 0
    maxPods            = var.enable_eni_prefix ? "110" : "$${MAX_PODS}"
  }, var.extra_config)
}
