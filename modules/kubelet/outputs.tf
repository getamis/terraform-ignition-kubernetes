output "systemd_units" {
  value = [
    data.ignition_systemd_unit.kubeinit_configs.rendered,
    data.ignition_systemd_unit.kubelet.rendered,
    data.ignition_systemd_unit.kubenode_shutdown.rendered,
  ]
}

output "files" {
  value = concat(
    [
      data.ignition_file.cni_plugin_tgz.rendered,
      data.ignition_file.envsubst.rendered,
      data.ignition_file.nerdctl.rendered,
      data.ignition_file.kubernetes_env.rendered,
      data.ignition_file.init_configs_sh.rendered,
      data.ignition_file.get_host_info_sh.rendered,
      data.ignition_file.node_shutdown_sh.rendered,
      data.ignition_file.kubelet_wrapper_sh.rendered,
      data.ignition_file.kubelet_env.rendered,
      data.ignition_file.systemd_drop_in_kubelet_conf.rendered,
      data.ignition_file.kubelet_config_tpl.rendered,
      data.ignition_file.kubelet_credential_provider_config_tpl.rendered,
      data.ignition_file.sysctl_k8s_conf.rendered,
      data.ignition_file.sysctl_max_user_watches_conf.rendered,
      data.ignition_file.logind_kubelet_conf.rendered,
    ],
    var.bootstrap_kubeconfig_content != "" ? [
      data.ignition_file.bootstrap_kubeconfig[0].rendered,
    ] : []
  )
}

