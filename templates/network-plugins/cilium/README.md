# How to generate Cilium manifests?

1. `helm repo add cilium https://helm.cilium.io/`
1. `helm pull cilium/cilium --version 1.16.1 --untar`
1. `mv cilium/values.yaml vxlan-values.yaml`
1. `rm cilium/values.schema.json` 
1. Update vxlan-values.yaml, make sure the template variables have not been replaced.
1. `helm template cilium ./cilium --version 1.16.1 -n kube-system -f vxlan-values.yaml | sed 's/{BIN_PATH}/BIN_PATH/g' > cilium-vxlan.yaml.tpl`
1. `rm -r cilium/`