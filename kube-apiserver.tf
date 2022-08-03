locals {
  merged_apiserver_flags = merge(
    local.apiserver_flags,
    local.audit_log_flags,
    {
      audit-policy-file          = "${local.etc_path}/config/policy.yaml"
      audit-log-path             = "${local.log_path}/kube-apiserver-audit.log"
      encryption-provider-config = "${local.etc_path}/config/encryption.yaml"
    },
    var.enable_iam_auth ? {
      authentication-token-webhook-config-file = var.auth_webhook_config_path,
    } : {},
    var.enable_irsa ? {
      service-account-signing-key-file = "${local.etc_path}/pki/sa.key",
      api-audiences                    = local.oidc_config.api_audiences
      service-account-issuer           = local.oidc_config.issuer
    } : {},
  )
}

data "ignition_file" "bootstrap_token_secret" {
  mode       = 420
  path       = "${local.etc_path}/addons/bootstrap-token-secret.yaml"

  content {
    content = templatefile("${path.module}/templates/bootstrap-token/secret.yaml.tpl", {
      id     = var.tls_bootstrap_token.id
      secret = var.tls_bootstrap_token.secret
    })
    mime = "text/yaml"
  }
}

data "ignition_file" "bootstrap_token_rbac" {
  mode       = 420
  path       = "${local.etc_path}/addons/bootstrap-token-rbac.yaml"

  content {
    content = templatefile("${path.module}/templates/bootstrap-token/rbac.yaml.tpl", {})
    mime = "text/yaml"
  }
}

data "ignition_file" "audit_log_policy" {
  mode       = 420
  path       = "${local.etc_path}/config/policy.yaml"

  content {
    content = templatefile("${path.module}/templates/configs/audit-policy.yaml.tpl", {
      content = var.audit_log_policy_content
    })
    mime = "text/yaml"
  }
}

data "ignition_file" "encryption_config" {
  mode       = 420
  path       = "${local.etc_path}/config/encryption.yaml"

  content {
    content = templatefile("${path.module}/templates/configs/encryption.yaml.tpl", {
      secret = base64encode(var.encryption_secret)
    })
    mime = "text/yaml"
  }
}

data "ignition_file" "kube_apiserver" {
  mode       = 420
  path       = "${local.etc_path}/manifests/kube-apiserver.yaml"

  content {
    content = templatefile("${path.module}/templates/manifests/kube-apiserver.yaml.tpl", {
      image          = "${local.containers["kube_apiserver"].repo}:${local.containers["kube_apiserver"].tag}"
      pki_path       = "${local.etc_path}/pki"
      etcd_pki_path  = "${local.etc_path}/pki/etcd"
      log_path       = local.log_path
      config_path    = "${local.etc_path}/config"
      secure_port    = var.apiserver_secure_port
      etcd_endpoints = var.etcd_endpoints
      cluster_cidr   = var.pod_network_cidr
      service_cidr   = var.service_network_cidr
      resources      = local.components_resource["kube_apiserver"]

      // TODO: move to merged_apiserver_flags
      cloud_provider    = local.cloud_config.provider
      cloud_config_flag = local.cloud_config.path != "" ? "- --cloud-config=${local.cloud_config.path}" : "# no cloud provider config given"
      extra_flags       = local.merged_apiserver_flags
    })
    mime = "text/yaml"
  }
}
