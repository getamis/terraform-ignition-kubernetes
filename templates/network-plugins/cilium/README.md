# How to generate Cilium manifests?

1. `helm repo add cilium https://helm.cilium.io/`
2. Update ["vxlan-values.yaml"]
3. `helm template cilium cilium/cilium --version 1.13.4 -n kube-system -f vxlan-values.yaml | sed 's/{BIN_PATH}/BIN_PATH/g' > cilium-vxlan.yaml.tpl`
