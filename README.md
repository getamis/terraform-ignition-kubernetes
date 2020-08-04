![Terraform test](https://github.com/getamis/terraform-kubernetes-ignition/workflows/Terraform%20test/badge.svg) [![GitHub license](https://img.shields.io/github/license/getamis/terraform-kubernetes-ignition)](https://github.com/getamis/terraform-kubernetes-ignition/blob/master/LICENSE)
# Terraform Kubernetes Ignition module
A terraform Ignition modules to bootstrap a Kubernetes cluster with CoreOS Container Linux/Flatcar Container Linux/Fedora CoreOS. (Experiment)

This repo also contains the following submodules:

* kubelet: Bootstrap a worker node to join a Kubernetes cluster.
* kubeconfig: Generate a kubeconfig from variabels.
* extra-addons.
  - [x] Addon manager.
  - [x] Metrics server.

## Features

* Kubernetes v1.18.6+.
* Supported [AWS VPC CNI](https://github.com/aws/amazon-vpc-cni-k8s), or [flannel](https://github.com/coreos/flannel) networking.
* RBAC-enabled, Audit log, and etcd data encryption.

## Requirements

* Terraform v0.12.0+.
* [terraform-provider-ignition](https://github.com/terraform-providers/terraform-provider-ignition) 1.2.1+.

## Usage example
The following block is show you how to use this module for bootstrapping a cluster:
 
 ```hcl
resource "random_id" "bootstrap_token_id" {
  byte_length = 3
}

resource "random_id" "bootstrap_token_secret" {
  byte_length = 8
}

resource "random_password" "encryption_secret" {
  length  = 32
  special = true
}

module "ignition_kubernetes" {
  source = "git::ssh://git@github.com/getamis/terraform-kubernetes-ignition"

  service_network_cidr = "10.96.0.0/12"
  pod_network_cidr     = "10.244.0.0/16"
  network_plugin       = "flannel"
  internal_endpoint    = "https://127.0.0.1:6443"
  etcd_endpoints       = "https://127.0.0.1:2379"
  encryption_secret    = random_password.encryption_secret.result

  tls_bootstrap_token = {
    id     = random_id.bootstrap_token_id.hex
    secret = random_id.bootstrap_token_secret.hex
  }

  // Create certs through https://github.com/getamis/vishwakarma/tree/master/modules/tls.
  certs = {
    etcd_ca_cert = module.etcd_cert.cert_pem

    ca_cert                       = module.kubernetes_ca.cert_pem
    ca_key                        = module.kubernetes_ca.private_key_pem
    admin_cert                    = module.admin_cert.cert_pem
    admin_key                     = module.admin_cert.private_key_pem
    apiserver_cert                = module.apiserver_cert.cert_pem
    apiserver_key                 = module.apiserver_cert.private_key_pem
    apiserver_kubelet_client_cert = module.apiserver_kubelet_client_cert.cert_pem
    apiserver_kubelet_client_key  = module.apiserver_kubelet_client_cert.private_key_pem
    apiserver_etcd_client_cert    = module.apiserver_etcd_client_cert.cert_pem
    apiserver_etcd_client_key     = module.apiserver_etcd_client_cert.private_key_pem
    controller_manager_cert       = module.controller_manager_cert.cert_pem
    controller_manager_key        = module.controller_manager_cert.private_key_pem
    scheduler_cert                = module.scheduler_cert.cert_pem
    scheduler_key                 = module.scheduler_cert.private_key_pem
    front_proxy_ca_cert           = module.front_proxy_ca.cert_pem
    front_proxy_ca_key            = module.front_proxy_ca.private_key_pem
    front_proxy_client_cert       = module.front_proxy_client_cert.cert_pem
    front_proxy_client_key        = module.front_proxy_client_cert.private_key_pem
    sa_pub                        = module.service_account.public_key_pem
    sa_key                        = module.service_account.private_key_pem
  }
}
```

> See [variables/master.md](docs/variables/master.md) for the detail variable inputs and outputs.

## Contributing
There are several ways to contribute to this project:

1. **Find bug**: create an issue in our Github issue tracker.
2. **Fix a bug**: check our issue tracker, leave comments and send a pull request to us to fix a bug.
3. **Make new feature**: leave your idea in the issue tracker and discuss with us then send a pull request!

## License
This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.
