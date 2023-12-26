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

require_ev_all KUBELET_IMAGE_REPO KUBELET_IMAGE_TAG
KUBELET_IMAGE="${KUBELET_IMAGE_REPO}:${KUBELET_IMAGE_TAG}"

source /opt/kubernetes/bin/get-host-info.sh
sudo sysctl --system

PARAMS=("$@")
[[ ! -z ${PROVIDER_ID} ]] && PARAMS+=(--provider-id=${PROVIDER_ID})

set -x
exec /opt/bin/nerdctl run --name kubelet \
  --log-driver=journald \
  --privileged \
  --pid host \
  --network host \
  --volume /etc/kubernetes:/etc/kubernetes \
  --volume /usr/lib/os-release:/etc/os-release:ro \
  --volume /etc/ssl/certs:/etc/ssl/certs:ro \
  --volume /lib/modules:/lib/modules:ro \
  --volume /run:/run \
  --volume /sys/fs/cgroup:/sys/fs/cgroup \
  --volume /usr/share/ca-certificates:/usr/share/ca-certificates:ro \
  --volume /var/lib/containerd/:/var/lib/containerd \
  --volume /var/lib/kubelet:/var/lib/kubelet:rshared \
  --volume /var/log:/var/log \
  --volume /var/run/lock:/var/run/lock \
  --volume /opt/cni/bin:/opt/cni/bin \
  --volume /opt/bin/ecr-credential-provider:/opt/bin/ecr-credential-provider \
  --volume /etc/cni/net.d:/etc/cni/net.d \
  ${KUBELET_IMAGE} \
    --node-ip=${HOST_IP} \
    --hostname-override=${HOSTNAME_FQDN} \
    "${PARAMS[@]}"
