module "admin_kubeconfig" {
  source = "./modules/kubeconfig"

  config_path = "/etc/kubernetes/admin.conf"

  cluster  = "kubernetes"
  context  = "kubernetes-admin@kubernetes"
  user     = "kubernetes-admin"
  endpoint = var.internal_endpoint

  certificates = {
    ca_cert     = var.certs["ca_cert"]
    client_cert = var.certs["admin_cert"]
    client_key  = var.certs["admin_key"]
  }
}

module "controller_manager_kubeconfig" {
  source = "./modules/kubeconfig"

  config_path = "/etc/kubernetes/controller-manager.conf"

  cluster  = "kubernetes"
  context  = "system:kube-controller-manager@kubernetes"
  user     = "system:kube-controller-manager"
  endpoint = var.internal_endpoint

  certificates = {
    ca_cert     = var.certs["ca_cert"]
    client_cert = var.certs["controller_manager_cert"]
    client_key  = var.certs["controller_manager_key"]
  }
}

module "scheduler_kubeconfig" {
  source = "./modules/kubeconfig"

  config_path = "/etc/kubernetes/scheduler.conf"

  cluster  = "kubernetes"
  context  = "system:kube-scheduler@kubernetes"
  user     = "system:kube-scheduler"
  endpoint = var.internal_endpoint

  certificates = {
    ca_cert     = var.certs["ca_cert"]
    client_cert = var.certs["scheduler_cert"]
    client_key  = var.certs["scheduler_key"]
  }
}

module "kubelet_kubeconfig" {
  source = "./modules/kubeconfig"

  config_path = "/etc/kubernetes/kubelet.conf"

  cluster  = "kubernetes"
  context  = "system:kubelet@kubernetes"
  user     = "system:kubelet"
  endpoint = var.internal_endpoint

  certificates = {
    ca_cert          = var.certs["ca_cert"]
    client_cert_path = "/var/lib/kubelet/pki/kubelet-client-current.pem"
    client_key_path  = "/var/lib/kubelet/pki/kubelet-client-current.pem"
  }
}

module "bootstrapping_kubeconfig" {
  source = "./modules/kubeconfig"

  config_path = "/etc/kubernetes/bootstrap-kubelet.conf"

  cluster  = "kubernetes"
  context  = "kubelet-bootstrap@kubernetes"
  user     = "kubelet-bootstrap"
  endpoint = var.internal_endpoint

  certificates = {
    ca_cert = var.certs["ca_cert"]
    token   = "${var.tls_bootstrap_token.id}.${var.tls_bootstrap_token.secret}"
  }
}