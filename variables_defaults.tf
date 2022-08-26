locals {
  containers = merge({
    kube_apiserver = {
      repo = "k8s.gcr.io/kube-apiserver"
      tag  = var.kubernetes_version
    }
    kube_controller_manager = {
      repo = "k8s.gcr.io/kube-controller-manager"
      tag  = var.kubernetes_version
    }
    kube_scheduler = {
      repo = "k8s.gcr.io/kube-scheduler"
      tag  = var.kubernetes_version
    }
    kube_proxy = {
      repo = "k8s.gcr.io/kube-proxy"
      tag  = var.kubernetes_version
    }
    coredns = {
      repo = "coredns/coredns"
      tag  = "1.9.1"
    }
    vpc_cni = {
      repo = "quay.io/amis/amazon-k8s-cni"
      tag  = "v1.11.3-nftables"
    }
    vpc_cni_init = {
      repo = "quay.io/amis/amazon-k8s-cni-init"
      tag  = "v1.11.3"
    }
    calico_node = {
      repo = "quay.io/calico/node"
      tag  = "v3.20.1"
    }
    calico_typha = {
      repo = "quay.io/calico/typha"
      tag  = "v3.20.1"
    }
    calico_autoscaler = {
      repo = "k8s.gcr.io/cluster-proportional-autoscaler-amd64"
      tag  = "1.8.5"
    }
    flannel_cni = {
      repo = "quay.io/coreos/flannel"
      tag  = "v0.14.0-amd64"
    }
  }, var.containers)

  cloud_config = merge({
    provider = "aws"
    path     = ""
  }, var.cloud_config)

  kubelet_cert = merge({
    algo   = "rsa"
    size   = 2048
    expiry = "87600h"
  }, var.kubelet_cert)

  kubelet_config = merge({
    clusterDomain = "cluster.local"
  }, var.kubelet_config)

  apiserver_flags = merge({
    allow-privileged = true
    profiling        = false

    service-account-issuer           = "https://kubernetes.default.svc"
    service-account-signing-key-file = "/etc/kubernetes/pki/sa.key"
    // TODO: fix livenessProbe while disabled anonymous auth. 
    // See https://kubernetes.io/docs/reference/access-authn-authz/authentication/#anonymous-requests for more information.
    anonymous-auth                  = true
    authorization-mode              = "Node,RBAC"
    enable-admission-plugins        = "NodeRestriction"
    enable-bootstrap-token-auth     = true
    kubelet-preferred-address-types = "InternalIP,ExternalIP,Hostname"
    tls-cipher-suites               = "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256"
  }, var.apiserver_flags)

  controller_manager_flags = merge({
    profiling                       = false
    leader-elect                    = true
    allocate-node-cidrs             = true
    controllers                     = "*,bootstrapsigner"
    node-monitor-grace-period       = "40s"
    pod-eviction-timeout            = "5m"
    configure-cloud-routes          = false
    use-service-account-credentials = true
    terminated-pod-gc-threshold     = 10
  }, var.controller_manager_flags)

  scheduler_flags = merge({
    profiling    = false
    leader-elect = true
  }, var.scheduler_flags)

  audit_log_flags = merge({
    audit-log-maxage    = 30
    audit-log-maxbackup = 10
    audit-log-maxsize   = 128
  }, var.audit_log_flags)

  coredns_config = merge({
    replicas                 = 2
    cluster_dns_ip           = cidrhost(var.service_network_cidr, 10)
    cluster_domain           = local.kubelet_config["clusterDomain"]
    upstream_nameservers     = "/etc/resolv.conf"
    located_on_the_same_host = false
  }, var.coredns_config)

  kube_proxy_config = merge({
    bindAddress        = "0.0.0.0"
    clusterCIDR        = var.pod_network_cidr
    metricsBindAddress = "0.0.0.0"
    mode               = "iptables"
  }, var.kube_proxy_config)

  oidc_config = merge({
    issuer        = ""
    api_audiences = ""
  }, var.oidc_config)

  components_resource = merge({
    kube_apiserver = {
      cpu_request    = "400m"
      memory_request = "1536Mi"
      cpu_limit      = "400m"
      memory_limit   = "1536Mi"
    },
    kube_controller_manager = {
      cpu_request    = "200m"
      memory_request = ""
      cpu_limit      = ""
      memory_limit   = ""
    },
    kube_scheduler = {
      cpu_request    = "100m"
      memory_request = ""
      cpu_limit      = ""
      memory_limit   = ""
    }
  }, var.components_resource)
}
