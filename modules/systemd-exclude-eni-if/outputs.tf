output "systemd_units" {
  value = []
}

output "files" {
  value = [
    data.ignition_file.systemd_networkd_conf.rendered,
  ]
}

