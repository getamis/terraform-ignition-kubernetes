#!/bin/bash
# Wrapper script for launching kubelet.

set -eu

function require_ev_all() {
	for rev in $@ ; do
		if [[ -z "${!rev}" ]]; then
			echo "${rev}" is not set
			exit 1
		fi
	done
}

KUBELET_BINARY=/usr/local/bin/kubelet

/usr/bin/podman network rm podman || rm -rf /etc/cni/net.d/cni.lock

source /usr/local/bin/get-host-info.sh

set -x

/usr/bin/podman run --name kubelet \
    --privileged \
    --pid host \
    --network host \
    --volume /etc/cni/net.d:/etc/cni/net.d:ro,z \
    --volume /etc/kubernetes:/etc/kubernetes:ro,z \
    --volume /usr/lib/os-release:/etc/os-release:ro \
    --volume /lib/modules:/lib/modules:ro \
    --volume /run:/run \
    --volume /sys/fs/cgroup:/sys/fs/cgroup \
    --volume /var/lib/calico:/var/lib/calico:ro \
    --volume /var/lib/docker:/var/lib/docker \
    --volume /var/lib/kubelet:/var/lib/kubelet:rshared,z \
    --volume /var/log:/var/log \
    --volume /var/run/lock:/var/run/lock:z \
    --volume /opt/cni/bin:/opt/cni/bin:z \
    quay.io/amis/kubelet:v1.23.5 \
        --node-ip=${HOST_IP} \
        --hostname-override=${HOSTNAME_FQDN} \
        --runtime-cgroups=/systemd/system.slice \
        --v=0 \
        "$@"