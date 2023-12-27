# How to generate the manifests?

### Amazon Network Policy Controller
1. git clone https://github.com/aws/amazon-network-policy-controller-k8s
1. Add generate-manefest to makefile
   ```
   .PHONY: generate-manifests
   generate-manifests: manifests kustomize
       cd config/controller && $(KUSTOMIZE) edit set image controller=${IMG}
       $(KUSTOMIZE) build config/default > config/amazon-network-policy-controller-k8s.yaml
   ```
1. `make generate-manifests`
1. Copy `config/amazon-network-policy-controller-k8s.yaml`

### AWS VPC CNI
1. Vendored from https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/v1.16.0/config/master/aws-k8s-cni.yaml
