variable "vault_uri" {
  type        = string
  description = "The URI endpoint of vault"
  default     = "http://127.0.0.1:8200"
}

variable "root_path" {
  type        = string
  description = "Where the root PKI secret backend will be mounted."
  default     = "pki"
}

variable "intermediate_path" {
  type        = string
  description = "Where the intermediate PKI secret backend will be mounted"
  default     = "pki_int"
}

variable "root_cn" {
  type        = string
  description = "Root Common Name"
  default     = "Root CA"
}

variable "ou" {
  type        = string
  description = "OU"
  default     = "My OU"
}

variable "organization" {
  type        = string
  description = "Organization"
  default     = "My Organization"
}

variable "country" {
  type        = string
  description = "Country"
  default     = "USA"
}

variable "province" {
  type        = string
  description = "The province/state"
  default     = "CA"
}

variable "locality" {
  type        = string
  description = "The locality"
  default     = "San Francisco"
}

variable "root_issuer_name" {
  type        = string
  description = "Name to the specified issuer."
  default     = "root-2023"
}

variable "int_cn" {
  type        = string
  description = "Intermediate Common Name"
  default     = "example.com Intermediate Authority"
}

variable "root_max_lease_ttl_seconds" {
  type        = number
  description = "Maximum possible lease duration for tokens and secrets in seconds."
  default     = 315360000
}

variable "int_default_lease_ttl_seconds" {
  type        = number
  description = "Default lease duration for tokens and secrets in seconds."
  default     = 0
}

variable "int_max_lease_ttl_seconds" {
  type        = number
  description = "Maximum possible lease duration for tokens and secrets in seconds."
  default     = 157680000
}

variable "int_pki_domain_role_ttl" {
  type        = number
  description = "Maximum possible lease duration for domain certificates"
  default     = 2628000
}

variable "enable_domain_cert_role" {
  type        = bool
  description = "Enable or disable domain cert role"
  default     = false
}

variable "int_pki_domain_role_name" {
  type        = string
  description = "Intermediate CA issuer domain cert role name"
  default     = "default-int-ca-domain-role"
}

variable "int_pki_client_role_ttl" {
  type        = number
  description = "Maximum possible lease duration for client certificates."
  default     = 31536000
}

variable "int_pki_client_role_name" {
  type        = string
  description = "Intermediate CA issuer client cert role name"
  default     = "default-int-ca-client-role"
}

variable "allowed_domains" {
  type        = list(string)
  description = "Domains for Intermediate CA Issuer Role."
  default     = ["example.com"]
}

variable "client_cert_cn" {
  type        = string
  description = "client Cert Common Name"
  default     = ""
}