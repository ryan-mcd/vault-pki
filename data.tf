data "vault_pki_secret_backend_issuers" "pki_int" {
  backend     = vault_pki_secret_backend_intermediate_set_signed.pki_int.backend
}