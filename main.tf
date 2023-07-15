resource "vault_mount" "root" {
  path                      = var.root_path
  type                      = "pki"
  default_lease_ttl_seconds = var.root_max_lease_ttl_seconds
  max_lease_ttl_seconds     = var.root_max_lease_ttl_seconds
}

resource "vault_pki_secret_backend_root_cert" "root" {
  depends_on            = [vault_mount.root]
  backend               = vault_mount.root.path
  type                  = "internal"
  common_name           = var.root_cn
  issuer_name           = var.root_issuer_name
  ttl                   = vault_mount.root.max_lease_ttl_seconds
  format                = "pem"
  key_type              = "rsa"
  key_bits              = 4096
  exclude_cn_from_sans  = true
  ou                    = var.ou
  organization          = var.organization
  country               = var.country
  province              = var.province
  locality              = var.locality
}

resource "vault_pki_secret_backend_config_urls" "root" {
  backend = vault_mount.root.path
  issuing_certificates    = [
    "${var.vault_uri}/v1/${vault_mount.root.path}/ca",
  ]
  crl_distribution_points = [
    "${var.vault_uri}/v1/${vault_mount.root.path}/crl",
  ]
  ocsp_servers            = [
    "${var.vault_uri}/v1/ocsp",
  ]
}

resource "vault_mount" "intermediate" {
  depends_on                = [ vault_pki_secret_backend_root_cert.root ]
  path                      = var.intermediate_path
  type                      = "pki"
  default_lease_ttl_seconds = var.int_default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.int_max_lease_ttl_seconds
}

resource "vault_pki_secret_backend_intermediate_cert_request" "pki_int" {
  backend     = vault_mount.intermediate.path
  type        = "internal"
  common_name = var.int_cn
}

resource "vault_pki_secret_backend_root_sign_intermediate" "pki_int" {
  backend              = vault_mount.root.path
  csr                  = vault_pki_secret_backend_intermediate_cert_request.pki_int.csr
  common_name          = var.int_cn
  exclude_cn_from_sans = true
  ou                    = var.ou
  organization          = var.organization
  country               = var.country
  province              = var.province
  locality              = var.locality
  revoke               = true
}

resource "vault_pki_secret_backend_intermediate_set_signed" "pki_int" {
  backend     = vault_mount.intermediate.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.pki_int.certificate
}

resource "vault_pki_secret_backend_role" "domain-certs" {
  count            = var.enable_domain_cert_role ? 1 : 0
  backend          = vault_mount.intermediate.path
  name             = var.int_pki_domain_role_name
  ttl              = var.int_pki_domain_role_ttl
#   issuer_ref       = data.vault_pki_secret_backend_issuers.pki_int.key_info[0]
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 4096
  allowed_domains  = var.allowed_domains
  allow_subdomains = true
}

resource "vault_pki_secret_backend_role" "client-certs" {
  backend          = vault_mount.intermediate.path
  name             = var.int_pki_client_role_name
  ttl              = var.int_pki_client_role_ttl
#   issuer_ref       = vault_pki_secret_backend_intermediate_set_signed.pki_int.imported_issuers
  allow_ip_sans    = false
  key_type         = "rsa"
  key_bits         = 2048
  allow_any_name   = true
}

resource "vault_pki_secret_backend_cert" "client-cert" {
  count       = var.client_cert_cn == "" ? 0 : 1
  backend     = vault_mount.intermediate.path
  name        = vault_pki_secret_backend_role.client-certs.name

  common_name = var.client_cert_cn
  revoke      = true
}