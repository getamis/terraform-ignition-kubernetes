data "ignition_file" "systemd_networkd_conf" {
  path       = "/etc/systemd/network/10-aws-vpc-cni.network"
  filesystem = "root"
  mode       = 420

  content {
    content = file("${path.module}/files/systemd/network/10-aws-vpc-cni.network")
  }
}
