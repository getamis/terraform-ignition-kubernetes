#!/bin/bash
# Kubernetes Node Graceful Shutdown Script

set -eu

function require_ev_all() {
	for rev in $@ ; do
		if [[ -z "${!rev}" ]]; then
			echo "${rev}" is not set
			exit 1
		fi
	done
}

function node_cleaning(){
	#	kubectl cordon node
	nerdctl run --rm \
		-v /etc/kubernetes/kubelet.conf:/root/.kube/config:ro \
		-v /var/lib/kubelet/pki/kubelet-client-current.pem:/var/lib/kubelet/pki/kubelet-client-current.pem:ro \
		--entrypoint=kubectl "${KUBECTL_IMAGE}" cordon "${HOSTNAME_FQDN}"

	# Gracefully shutdown kubelet
	systemctl stop kubelet.service

	# kubectl delete node
	nerdctl run --rm \
		-v /etc/kubernetes/kubelet.conf:/root/.kube/config:ro \
		-v /var/lib/kubelet/pki/kubelet-client-current.pem:/var/lib/kubelet/pki/kubelet-client-current.pem:ro \
		--entrypoint=kubectl "${KUBECTL_IMAGE}" delete node "${HOSTNAME_FQDN}"

	# Exit node-shutdown script to release inhibitor lock
	exit 0
}

require_ev_all KUBECTL_IMAGE_REPO KUBECTL_IMAGE_TAG
KUBECTL_IMAGE="${KUBECTL_IMAGE_REPO}:${KUBECTL_IMAGE_TAG}"
source /opt/kubernetes/bin/get-host-info.sh

set -x

# Read PrepareForShutdown DBus signal to graceful shutdown kubelet node.
while true; do
	while read -r signal; do
		case "$signal" in
			*PrepareForShutdown*)	node_cleaning ;;
			*)										echo "Ignore unknown signal." ;;
		esac
	done < <(dbus-monitor --system "type='signal', interface='org.freedesktop.login1.Manager', member='PrepareForShutdown'")
done 
