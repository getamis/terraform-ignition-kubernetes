locals {
  containers = merge({
    kube_apiserver = {
      repo = "registry.k8s.io/kube-apiserver"
      tag  = var.kubernetes_version
    }
    kube_controller_manager = {
      repo = "registry.k8s.io/kube-controller-manager"
      tag  = var.kubernetes_version
    }
    kube_scheduler = {
      repo = "registry.k8s.io/kube-scheduler"
      tag  = var.kubernetes_version
    }
    kube_proxy = {
      repo = "registry.k8s.io/kube-proxy"
      tag  = var.kubernetes_version
    }
    coredns = {
      repo = "coredns/coredns"
      tag  = "1.11.3"
    }
    vpc_cni = {
      repo = "602401143452.dkr.ecr.us-west-2.amazonaws.com/amazon-k8s-cni"
      tag  = "v1.19.2"
    }
    vpc_cni_init = {
      repo = "602401143452.dkr.ecr.us-west-2.amazonaws.com/amazon-k8s-cni-init"
      tag  = "v1.19.2"
    }
    aws_network_policy_agent = {
      repo = "602401143452.dkr.ecr.us-west-2.amazonaws.com/amazon/aws-network-policy-agent"
      tag  = "v1.1.6"
    }
    aws_network_policy_controller = {
      repo = "602401143452.dkr.ecr.us-west-2.amazonaws.com/eks/amazon-network-policy-controller-k8s"
      tag  = "v1.0.7"
    }
    flannel_cni = {
      repo = "quay.io/coreos/flannel"
      tag  = "v0.14.0-amd64"
    }
    cilium_agent = {
      repo = "quay.io/cilium/cilium"
      tag  = "v1.16.1"
    }
    cilium_operator = {
      repo = "quay.io/cilium/operator"
      tag  = "v1.16.1"
    }
    hubble_relay = {
      repo = "quay.io/cilium/hubble-relay"
      tag  = "v1.16.1"
    }
    cilium_certgen = {
      repo = "quay.io/cilium/certgen"
      tag  = "v0.1.9"
    }
    cloud_controller_manager = {
      repo = "registry.k8s.io/provider-aws/cloud-controller-manager"
      tag  = "v1.31.0"
    }
  }, var.containers)

  cloud_provider = "aws"

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
    allocate-node-cidrs             = var.network_plugin == "cilium-vxlan" ? false : true
    controllers                     = "*,bootstrapsigner"
    node-monitor-grace-period       = "40s"
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

  ccm_config = merge(
    {
      use_service_account_credentials = true
      configure_cloud_routes          = false
  }, var.ccm_config)

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
