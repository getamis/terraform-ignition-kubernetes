locals {
  binaries = merge({
    cni_plugin = {
      source   = "https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz"
      checksum = "sha512-4d0ed0abb5951b9cf83cba938ef84bdc5b681f4ac869da8143974f6a53a3ff30c666389fa462b9d14d30af09bf03f6cdf77598c572f8fb3ea00cecdda467a48d"
    }
    },
    {
      envsubst = {
        source   = "https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst-Linux-x86_64"
        checksum = "sha512-91dfd502ab14173ac8af35ca318c9872ec3e0b04b34580b65f787faead355e29ca9609aaeb6ca0629d7dd9cfaeaa83769a166eb03923ae19441da04150e865c6"
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
    cfssl = {
      repo = "quay.io/amis/cfssl"
      tag  = "v1.6.1"
    }
  }, var.containers)

  cloud_provider = "aws"

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

    # https://github.com/containerd/containerd/issues/4857
    cgroupDriver             = "systemd"
    containerRuntimeEndpoint = "unix:///run/containerd/containerd.sock"
    volumePluginDir          = "/var/lib/kubelet/volumeplugins"
    clusterDNS               = [cidrhost(var.service_network_cidr, 10)]
    clusterDomain            = "cluster.local"
    healthzBindAddress       = "127.0.0.1"
    healthzPort              = 0
    readOnlyPort             = 0
    maxPods                  = var.network_plugin != "amazon-vpc" || (var.network_plugin == "amazon-vpc" && var.enable_eni_prefix) ? var.max_pods : "$${MAX_PODS}"
  }, var.extra_config)
}
