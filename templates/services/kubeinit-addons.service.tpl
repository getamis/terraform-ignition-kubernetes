[Unit]
Description=Systemd unit for initing Kubernetes resources
After=kubelet.service

[Service]
Type=simple
RemainAfterExit=true

Environment="PATH=/opt/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin"
EnvironmentFile=-/etc/default/kubernetes.env
Environment="ADDONS_PATH=${path}"
ExecStart=/opt/kubernetes/bin/init-addons
      
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
