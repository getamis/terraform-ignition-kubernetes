# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this
project adheres to [Semantic Versioning](http://semver.org/).


<a name="v1.0.0"></a>
## v1.0.0 - 2020-10-20
ENHANCEMENTS:
- update docs, add v1 changelog, and update Makefile
- update list of addons ([#15](https://github.com/getamis/terraform-ignition-kubernetes/issues/15))
- update README.md ([#5](https://github.com/getamis/terraform-ignition-kubernetes/issues/5))

FEATURES:
- bump aws cni to v1.7 ([#25](https://github.com/getamis/terraform-ignition-kubernetes/issues/25))
- add tolerations and nodeSelector to pod identity webhook ([#16](https://github.com/getamis/terraform-ignition-kubernetes/issues/16))
- merge iam-auth webhook module to iam-auth addon module ([#13](https://github.com/getamis/terraform-ignition-kubernetes/issues/13))
- add IRSA support for out of cluster tls cert ([#12](https://github.com/getamis/terraform-ignition-kubernetes/issues/12))
- bump Kubernetes version to 1.19.0 ([#11](https://github.com/getamis/terraform-ignition-kubernetes/issues/11))
- add aws pod identity webhook ([#10](https://github.com/getamis/terraform-ignition-kubernetes/issues/10))
- add aws iam auth addon ([#9](https://github.com/getamis/terraform-ignition-kubernetes/issues/9))
- add aws-iam-authenticator webhook ([#8](https://github.com/getamis/terraform-ignition-kubernetes/issues/8))

BUG FIXES:
- update CoreDNS forward ([#24](https://github.com/getamis/terraform-ignition-kubernetes/issues/24))
- make irsa addon only support in cluster mode ([#22](https://github.com/getamis/terraform-ignition-kubernetes/issues/22))
- use kubernetes.io path for token-mount-path var ([#21](https://github.com/getamis/terraform-ignition-kubernetes/issues/21))
- update aws iam-auth default vars ([#20](https://github.com/getamis/terraform-ignition-kubernetes/issues/20))
- fix aws iam-auth template render ([#19](https://github.com/getamis/terraform-ignition-kubernetes/issues/19))
- remove count for ignition_file ([#17](https://github.com/getamis/terraform-ignition-kubernetes/issues/17))
- rename cert_path to pki_dir_path ([#14](https://github.com/getamis/terraform-ignition-kubernetes/issues/14))


[Unreleased]: https://github.com/getamis/terraform-ignition-kubernetes/compare/v1.0.0...HEAD
