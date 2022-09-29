output "systemd_units" {
  value = concat([
    data.ignition_systemd_unit.kubeinit_addons.rendered,
    ],
    module.kubelet.systemd_units
  )
}

output "files" {
  value = concat(
    [
      data.ignition_file.init_addons_sh.rendered,
      data.ignition_file.kube_apiserver.rendered,
      data.ignition_file.kube_controller_manager.rendered,
      data.ignition_file.kube_scheduler.rendered,
      data.ignition_file.coredns.rendered,
      data.ignition_file.bootstrap_token_secret.rendered,
      data.ignition_file.bootstrap_token_rbac.rendered,
      data.ignition_file.audit_log_policy.rendered,
      data.ignition_file.encryption_config.rendered,
    ],
    var.network_plugin == "amazon-vpc" ? [
      data.ignition_file.kube_proxy.rendered,
      data.ignition_file.kube_proxy_cm.rendered,
      data.ignition_file.aws_vpc_cni_yaml[0].rendered,
    ] : [],
    var.network_plugin == "flannel" ? [
      data.ignition_file.kube_proxy.rendered,
      data.ignition_file.kube_proxy_cm.rendered,
      data.ignition_file.flannel_yaml[0].rendered,
    ] : [],
    var.network_plugin == "cilium-vxlan" ? [
      data.ignition_file.cilium_vxlan_yaml[0].rendered,
    ] : [],
    var.enable_calico ? [
      data.ignition_file.aws_cni_calico_yaml[0].rendered,
    ] : [],
    module.kubelet.files,
    module.admin_kubeconfig.files,
    module.controller_manager_kubeconfig.files,
    module.scheduler_kubeconfig.files,
    module.kubelet_kubeconfig.files,
  )
}

output "cert_files" {
  value = [
    data.ignition_file.kubernetes_ca_cert.rendered,
    data.ignition_file.kubernetes_ca_key.rendered,
    data.ignition_file.etcd_ca_cert.rendered,
    data.ignition_file.front_proxy_ca_cert.rendered,
    data.ignition_file.front_proxy_ca_key.rendered,
    data.ignition_file.apiserver_cert.rendered,
    data.ignition_file.apiserver_key.rendered,
    data.ignition_file.apiserver_kubelet_client_cert.rendered,
    data.ignition_file.apiserver_kubelet_client_key.rendered,
    data.ignition_file.apiserver_etcd_client_cert.rendered,
    data.ignition_file.apiserver_etcd_client_key.rendered,
    data.ignition_file.front_proxy_client_cert.rendered,
    data.ignition_file.front_proxy_client_key.rendered,
    data.ignition_file.service_account_public_key.rendered,
    data.ignition_file.service_account_private_key.rendered,
    data.ignition_file.kubelet_csr_json_tpl.rendered,
    data.ignition_file.ca_config_json_tpl.rendered,
  ]
}

output "admin_kubeconfig_content" {
  sensitive = true
  value     = module.admin_kubeconfig.content
}

output "bootstrap_kubeconfig_content" {
  sensitive = true
  value     = module.bootstrapping_kubeconfig.content
}
