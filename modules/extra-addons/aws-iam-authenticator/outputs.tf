output "files" {
  value = [
    data.ignition_file.iam_authenticator.rendered,
  ]
}