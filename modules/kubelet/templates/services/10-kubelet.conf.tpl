[Service]
Environment="PATH=/opt/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin"
Environment="KUBELET_KUBECONFIG_ARGS=--bootstrap-kubeconfig=${bootstrap_kubeconfig} --kubeconfig=${kubeconfig}"
Environment="KUBELET_CONFIG_ARGS=--config=/var/lib/kubelet/config.yaml --image-credential-provider-config=/var/lib/kubelet/credential_provider.yaml --image-credential-provider-bin-dir=/opt/bin/ecr-credential-provider"
EnvironmentFile=-/etc/default/kubernetes.env
EnvironmentFile=-/var/lib/kubelet/kubelet-flags.env
ExecStart=
ExecStartPre=-/bin/docker rm kubelet
ExecStart=systemd-inhibit --what=shutdown --mode=delay /opt/kubernetes/bin/kubelet-wrapper $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_NETWORK_ARGS $KUBELET_CLOUD_PROVIDER_ARGS $KUBELET_EXTRA_ARGS
ExecStop=/bin/bash -c "docker stop kubelet && crictl stop -t 60 $$(crictl ps -q)"
