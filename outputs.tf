output "csr" {
  value = vault_pki_secret_backend_intermediate_cert_request.pki_int.csr
}

output "int_pki_backend_path" {
    value = vault_mount.intermediate.path
}

output "int_pki_client_role_name" {
    value = vault_pki_secret_backend_role.client-certs.name
}

output "client_cert" {
  value = vault_pki_secret_backend_cert.client-cert
}

output "root_ca_cert" {
  value = vault_pki_secret_backend_root_cert.root.certificate
}

output "int_ca_cert" {
  value = vault_pki_secret_backend_intermediate_set_signed.pki_int.certificate
}

output "ca_cert" {
  value = <<-EOT
  ${vault_pki_secret_backend_root_cert.root.certificate}
  ${vault_pki_secret_backend_intermediate_set_signed.pki_int.certificate}
  EOT
}