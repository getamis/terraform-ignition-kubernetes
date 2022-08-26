TF_DOCS := $(shell which terraform-docs 2> /dev/null)
TF_FILES = $(shell find . -type f -name "*.tf" -exec dirname {} \; | sort -u)
TF_TESTS = $(shell find ./tests -type f -name "*.tf" -exec dirname {} \;|sort -u)

SEMTAG=tools/semtag
TAG_QUERY=v1.0.0..

scope ?= "minor"

define terraform-docs
	$(if $(TF_DOCS),,$(error "terraform-docs revision >= a8b59f8 is required (https://github.com/segmentio/terraform-docs)"))

	@echo '<!-- DO NOT EDIT. THIS FILE IS GENERATED BY THE MAKEFILE. -->' > $1
	@echo '# Terraform variables inputs and outputs' >> $1
	@echo $2 >> $1
	terraform-docs markdown $3 $4 $5 $6 >> $1
endef

.PHONY: validate
validate:
	@for m in $(TF_TESTS); do terraform init "$$m" > /dev/null 2>&1; echo "$$m: "; cd "$$m" ;terraform validate "."; cd -; done

.PHONY: validate-ign
validate-ign:
	@(cd tests && \
	  terraform init > /dev/null 2>&1 && \
	  terraform apply -auto-approve && \
	  (ignition-validate output/k8s.ign && echo "√ output/k8s.ign: Success! The ignition configuration is valid."))
	
.PHONY: fmt
fmt:
	@for m in $(TF_FILES); do (terraform fmt -diff "$$m" && echo "√ $$m"); done
	
.PHONY: changelog
changelog:
	git-chglog -o CHANGELOG.md $(TAG_QUERY)

.PHONY: release
release:
	$(SEMTAG) final -s $(scope)

.PHONY: docs
docs:
	$(call terraform-docs, docs/variables/master.md, \
		'This document gives an overview of variables used in the Ignition of the Kubernetes master module.\n', \
		./)
	
	$(call terraform-docs, docs/variables/kubelet.md, \
		'This document gives an overview of variables used in the Ignition of the Kubernetes kubelet module.\n', \
		./modules/kubelet)
	
	$(call terraform-docs, docs/variables/kubeconfig.md, \
		'This document gives an overview of variables used in the Ignition of the Kubernetes kubeconfig module.\n', \
		./modules/kubeconfig)

	$(call terraform-docs, docs/variables/extra-addons/addon-manager.md, \
		'This document gives an overview of variables used in the Ignition of the addon-manager module.\n', \
		./modules/extra-addons/addon-manager)

	$(call terraform-docs, docs/variables/extra-addons/metrics-server.md, \
		'This document gives an overview of variables used in the Ignition of the metrics-server module.\n', \
		./modules/extra-addons/metrics-server)