output "csr" {
  value = vault_pki_secret_backend_intermediate_cert_request.pki_int.csr
}

output client_cert {
    value = vault_pki_secret_backend_cert.client-cert
}