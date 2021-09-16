locals {
  binaries = merge({
    kubelet = {
      source   = "https://dl.k8s.io/${var.kubernetes_version}/kubernetes-node-linux-amd64.tar.gz"
      checksum = "sha512-57eeae81081e06e35484b353be04f18bf5c2556175a0355d63cbe3eea80d51decfae28eb42cb5fc8907492a70e4e9bae54bd86956caea7c3a51b1fc909feaea6"
    }
    cni_plugin = {
      source   = "https://github.com/containernetworking/plugins/releases/download/v1.0.0/cni-plugins-linux-amd64-v1.0.0.tgz"
      checksum = "sha512-276633e8750e56fe864ba60fd3efef81c2157385219770a410cd7e423e88d68c024470b82420776d34027182227352f391a03cfd2e97ede9d0c7d8fa8fd578ec"
    }
  }, var.binaries)

  containers = merge({
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
    hairpinMode        = "hairpin-veth"
    cgroupDriver       = "systemd"
    kubeletCgroups     = "/systemd/system.slice"
    healthzBindAddress = "127.0.0.1"
    healthzPort        = 0
    readOnlyPort       = 0
    maxPods            = "$${MAX_PODS}"
  }, var.extra_config)
}
