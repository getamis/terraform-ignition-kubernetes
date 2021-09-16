[Unit]
Description=kubelet: The Kubernetes Node Agent
Documentation=https://kubernetes.io/docs/home/
Requires=afterburn.service
After=afterburn.service
Wants=rpc-statd.service

[Service]
Restart=always
RestartSec=10s
TimeoutStartSec=0
StartLimitInterval=0
LimitNOFILE=40000

User=root
Group=root

Environment="KUBELET_KUBECONFIG_ARGS=--bootstrap-kubeconfig=${bootstrap_kubeconfig} --kubeconfig=${kubeconfig}"
Environment="KUBELET_CONFIG_ARGS=--config=/var/lib/kubelet/config.yaml"
Environment="KUBELET_NETWORK_ARGS=--network-plugin=cni"
EnvironmentFile=-/etc/default/kubernetes.env
EnvironmentFile=-/var/lib/kubelet/kubelet-flags.env
ExecStartPre=-/usr/bin/podman rm kubelet
ExecStart=/usr/local/bin/kubelet-wrapper.sh $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_NETWORK_ARGS $KUBELET_EXTRA_ARGS
ExecStop=/usr/bin/podman stop kubelet

[Install]
WantedBy=multi-user.target
RequiredBy=kubeinit-addons.service