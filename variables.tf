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

variable "locality" {
  type        = string
  description = "The locality"
  default     = "CA"
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

variable "domain" {
  type        = map(string)
  description = "Domains for Intermediate CA."
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