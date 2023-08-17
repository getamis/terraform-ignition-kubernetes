data "ignition_file" "aws_cloud_controller_manager" {
  count = var.cloud_provider == "aws" ? 1 : 0

  mode      = 420
  path      = "${local.etc_path}/addons/aws-ccm.yaml"
  overwrite = true

  content {
    content = templatefile("${path.module}/templates/cloud-provider/aws-ccm.yaml.tpl", {
      image                           = "${local.containers["cloud_controller_manager"].repo}:${local.containers["cloud_controller_manager"].tag}"
      configure_cloud_routes          = local.ccm_config["configure_cloud_routes"]
      use_service_account_credentials = local.ccm_config["use_service_account_credentials"]
    })
    mime = "text/yaml"
  }
}