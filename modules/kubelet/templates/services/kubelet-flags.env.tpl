KUBELET_CLOUD_PROVIDER_ARGS="${kubelet_cloud_provider_flag}"
KUBELET_EXTRA_ARGS="%{ for flag, value in extra_flags ~}%{ if value != "" ~} --${flag}=${value} %{ endif ~}%{ endfor ~}--v=${log_level}"