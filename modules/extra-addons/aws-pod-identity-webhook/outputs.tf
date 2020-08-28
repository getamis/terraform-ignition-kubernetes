output "files" {
  value = concat(
    [data.ignition_file.pod_identity_webhook.rendered],
    var.tls_cert != "" ? [data.ignition_file.tls_cert[0].rendered] : [],
    var.tls_key != "" ? [data.ignition_file.tls_key[0].rendered] : [],
  )
}
