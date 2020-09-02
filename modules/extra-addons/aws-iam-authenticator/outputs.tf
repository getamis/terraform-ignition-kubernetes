output "files" {
  value = [
    data.ignition_file.iam_authenticator.rendered,
    data.ignition_file.kubeconfig.rendered,
    data.ignition_file.iam_auth_cert.rendered,
    data.ignition_file.iam_auth_key.rendered,
  ]
}

output "kubeconfig_path" {
  value = "${pathexpand(var.kubeconfig_dir_path)}/kubeconfig"
}
