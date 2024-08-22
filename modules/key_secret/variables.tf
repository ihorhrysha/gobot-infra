variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "key_ring_name" {
  description = "The name of the key ring"
  type        = string
}

variable "crypto_key_name" {
  description = "The name of the crypto key"
  type        = string
}

variable "secret_id" {
  description = "The ID of the secret"
  type        = string
}

variable "secret_data" {
  description = "The data of the secret"
  type        = string
}

variable "service_account_id" {
  description = "The ID of the service account"
  type        = string
}

variable "service_account_display_name" {
  description = "The display name of the service account"
  type        = string
}