output "key_ring_name" {
  description = "The name of the key ring"
  value       = google_kms_key_ring.key_ring.name
}

output "crypto_key_name" {
  description = "The name of the crypto key"
  value       = google_kms_crypto_key.crypto_key.name
}

output "secret_id" {
  description = "The ID of the secret"
  value       = google_secret_manager_secret.tele_token.secret_id
}

output "service_account_email" {
  description = "The email of the service account"
  value       = google_service_account.service_account.email
}