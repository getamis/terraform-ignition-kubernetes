[Unit]
Description = Systemd unit for initing Kubernetes configs
ConditionPathExists = !/opt/kubernetes/init-configs.done
After = network-online.target
Wants = network-online.target
Before=kubelet.service

[Service]
Type=oneshot
RemainAfterExit=true

User=root
Group=root

EnvironmentFile=-/etc/default/kubernetes.env
ExecStart=/usr/local/bin/kubeinit-configs.sh
ExecStartPost=/bin/touch /opt/kubernetes/init-configs.done

[Install]
WantedBy=multi-user.target
RequiredBy=kubelet.service
