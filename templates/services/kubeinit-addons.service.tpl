[Unit]
Description=Systemd unit for initing Kubernetes resources
After=kubelet.service

[Service]
Type=simple
RemainAfterExit=true

EnvironmentFile=-/etc/default/kubernetes.env
Environment="ADDONS_PATH=${path}"
ExecStart=/usr/local/bin/init-addons
      
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
