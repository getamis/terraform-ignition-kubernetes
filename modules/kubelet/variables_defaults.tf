locals {
  binaries = merge({
    cni_plugin = {
      source   = "https://github.com/containernetworking/plugins/releases/download/v0.8.6/cni-plugins-linux-amd64-v0.8.6.tgz"
      checksum = "sha512-76b29cc629449723fef45db6a6999b0617e6c9084678a4a3361caf3fc5e935084bc0644e47839b1891395e3cec984f7bfe581dd9455c4991ddeee1c78392e538"
    }
  }, var.binaries)

  containers = merge({
    kubelet = {
      repo = "quay.io/poseidon/kubelet"
      tag  = var.kubernetes_version
    }
    // Included kubectl tool, See https://github.com/poseidon/kubelet for more information.
    kubectl = {
      repo = "quay.io/poseidon/kubelet"
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
    maxPods            = "$${MAX_PODS}"
  }, var.extra_config)
}
