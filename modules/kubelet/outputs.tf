output "systemd_units" {
  value = [
    data.ignition_systemd_unit.kubeinit_configs.rendered,
    data.ignition_systemd_unit.kubelet.rendered,
  ]
}

output "files" {
  value = [
    data.ignition_file.cni_plugin_tgz.rendered,
    data.ignition_file.kubernetes_env.rendered,
    data.ignition_file.init_configs_sh.rendered,
    data.ignition_file.get_host_info_sh.rendered,
    data.ignition_file.kubelet_wrapper_sh.rendered,
    data.ignition_file.kubelet_env.rendered,
    data.ignition_file.systemd_drop_in_kubelet_conf.rendered,
    data.ignition_file.kubelet_config_tpl.rendered,
    data.ignition_file.sysctl_k8s_conf.rendered,
    data.ignition_file.sysctl_max_user_watches_conf.rendered,
  ]
}

