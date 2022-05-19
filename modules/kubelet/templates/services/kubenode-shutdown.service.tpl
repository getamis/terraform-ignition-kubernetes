[Unit]
Description = Kubernetes node graceful shutdown script

[Service]
Type=oneshot
RemainAfterExit=true

Environment="PATH=/opt/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin"
EnvironmentFile=-/etc/default/kubernetes.env
ExecStart=systemd-inhibit --what=shutdown --mode=delay /opt/kubernetes/bin/node-shutdown

[Install]
WantedBy=multi-user.target
