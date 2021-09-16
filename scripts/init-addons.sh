#!/bin/bash
# Wrapper script for initing Kubernetes resources.

set -eu

function require_ev_all() {
	for rev in $@ ; do
		if [[ -z "${!rev}" ]]; then
			echo "${rev}" is not set
			exit 1
		fi
	done
}

KUBECTL_BINARY=/usr/local/bin/kubectl

mkdir -p ${ADDONS_PATH}

source /usr/local/bin/get-host-info.sh
export KUBECONFIG=/etc/kubernetes/admin.conf

set -x
${KUBECTL_BINARY} label node ${HOSTNAME_FQDN} node-role.kubernetes.io/master="" --overwrite
${KUBECTL_BINARY} apply -f ${ADDONS_PATH}
