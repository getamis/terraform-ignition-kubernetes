[Unit]
Description = Systemd unit for initing Kubernetes configs
ConditionPathExists = !/opt/kubernetes/init-configs.done
Before=kubelet.service
After=network.target

[Service]
Type=oneshot
RemainAfterExit=true

User=root
Group=root

Environment="PATH=/opt/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin"
EnvironmentFile=-/etc/default/kubernetes.env
ExecStart=/opt/kubernetes/bin/init-configs
ExecStartPost=/bin/touch /opt/kubernetes/init-configs.done

[Install]
WantedBy=multi-user.target
RequiredBy=kubelet.service
