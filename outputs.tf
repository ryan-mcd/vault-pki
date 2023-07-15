output "csr" {
  value = vault_pki_secret_backend_intermediate_cert_request.pki_int.csr
}

output "int_pki_backend_path" {
    value = vault_mount.intermediate.path
}

output "int_pki_client_role_name" {
    value = vault_pki_secret_backend_role.client-certs.name
}

output client_cert {
  value = vault_pki_secret_backend_cert.client-cert
}