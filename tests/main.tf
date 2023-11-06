terraform {
  required_version = ">= 1.5.0"

  required_providers {
    ignition = {
      source  = "community-terraform-providers/ignition"
      version = "2.1.2"
    }
  }
}

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
  source = "../"

  service_network_cidr = "10.96.0.0/12"
  pod_network_cidr     = "10.244.0.0/16"
  network_plugin       = "flannel"
  internal_endpoint    = "https://127.0.0.1:6443"
  etcd_endpoints       = "https://127.0.0.1:2379"
  encryption_secret    = random_password.encryption_secret.result
  log_level = {
    aws_cloud_controller_manager = "4"
    containerd                   = "debug"
    cilium_cni                   = "DEBUG"
  }

  tls_bootstrap_token = {
    id     = random_id.bootstrap_token_id.hex
    secret = random_id.bootstrap_token_secret.hex
  }

  certs = {
    etcd_ca_cert = "1JR6RQsGgj5MkYrsvnA87CmB9/GgKLje7TVuV4WnpfI="

    ca_cert                       = "0UJHPe+UtjQAed6LhHLGcX1+QrISIX/5Bt/zRcCETwg="
    ca_key                        = "EcVHdpIwHltNSwRAl0jHfN0wC9gNFGgYoJ9KZvokYEc="
    admin_cert                    = "6QtninR/MVATtac7wfUKu4gpHydi3zRQzIcIHU9ozjw="
    admin_key                     = "YpTT+PjcuC5CybVcl6QxilZ0R+J0sHrarXZbvMxkOBY="
    apiserver_cert                = "/iIrHSh4RCT7OZshAc08wGPDBG9LXPpBqXfsMxjICug="
    apiserver_key                 = "hxIRmFbWaDCcNX4DCxRL3K8tsSGp/GDGSNiD22F0vAM="
    apiserver_kubelet_client_cert = "btKP9rofBTAP13qt2J9bfQqyeDyXzgnt2cWR+97eGsE="
    apiserver_kubelet_client_key  = "nQGiyCE9BFxIH/vyETEYzNwY4kwnzAYGgtW8leYVxzg="
    apiserver_etcd_client_cert    = "u1CjxP3EsRRQoyYdMhujS6EJypnI/MzM+7k05HMxexo="
    apiserver_etcd_client_key     = "2iPUCEALAAcf33WNhyEWICjl9PHM7bQvTrfojyrDLEI="
    controller_manager_cert       = "GZbupgQT6We+nCiaBZOtOJsABuqfEwK3Kq3qopIZ1MY="
    controller_manager_key        = "N3DSa/IRNXm27yj2HBA8ioa2Kh6odzOCAWc/DSbX9Kw="
    scheduler_cert                = "R9K3FJuBw6S3TACQxcBcn6YO5sgN27TUEgvkYqEzNLg="
    scheduler_key                 = "4wItHrT6CKASLSaYDC89kZvEgUR0k+s91t97Nxud9XI="
    front_proxy_ca_cert           = "MablFnDw4eP6f9FHz95l/bzo4rUW6TRzHKZzFAUfguU="
    front_proxy_ca_key            = "dWwwluo9gkMjnHb0ZzKARU4AldP4w/jo73l0PV/iDro="
    front_proxy_client_cert       = "vgaw53vwIiaoajlUSl4XNcUVHXBOzygSciGzQB2SAjU="
    front_proxy_client_key        = "EWfrVxHeSaXzgD2PNQBCT8Ip4ece2bZTJZYJmJQf0pY="
    sa_pub                        = "x6PXLHszHxv7SsIUhcm4esK7bQEh4dlif1R+r3y71C0="
    sa_key                        = "8G3WG3nqDcUE8hKW3KbYbMh+zwjWxzy6VB2Z1I247c4="
  }
}

module "ignition_pod_identity_webhook" {
  source = "../modules/extra-addons/aws-pod-identity-webhook"

  mutating_webhook_ca_bundle = "ah51X/ww7hQOikZ6sPKH5Gs3B99o6BGSddMVJL21Kw8="
  tls_cert                   = "+PyFzGjjjcoRJ33MjnH5FFWlycxbw/gsY1lMlMN1DxE="
  tls_key                    = "3Bhk5ZKRxaxJNnviFa2zP5hAAP+EBY75ag+HpI4OyzQ="
}

module "ignition_aws_iam_authenticator" {
  source = "../modules/extra-addons/aws-iam-authenticator"

  cluster_name  = "test-kubernetes"
  auth_ca_cert  = "ah51X/ww7hQOikZ6sPKH5Gs3B99o6BGSddMVJL21Kw8="
  auth_cert     = "+PyFzGjjjcoRJ33MjnH5FFWlycxbw/gsY1lMlMN1DxE="
  auth_cert_key = "3Bhk5ZKRxaxJNnviFa2zP5hAAP+EBY75ag+HpI4OyzQ="
}

data "ignition_config" "main" {
  files = concat(
    module.ignition_kubernetes.files,
    module.ignition_pod_identity_webhook.files,
    module.ignition_aws_iam_authenticator.files,
  )
  systemd = module.ignition_kubernetes.systemd_units
}

resource "local_file" "file" {
  content  = data.ignition_config.main.rendered
  filename = "${path.root}/output/k8s.ign"
}
