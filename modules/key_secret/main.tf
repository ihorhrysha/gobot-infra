provider "google" {
  project = var.project_id
  region  = var.region
}

# Step 1: Create a key ring and key
resource "google_kms_key_ring" "key_ring" {
  name     = var.key_ring_name
  location = "global"
}

resource "google_kms_crypto_key" "crypto_key" {
  name     = var.crypto_key_name
  key_ring = google_kms_key_ring.key_ring.id
}

# Step 2: Create a Secret Manager secret and encrypt it using the key
resource "google_secret_manager_secret" "tele_token" {
  secret_id = var.secret_id
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "tele_token_version" {
  secret      = google_secret_manager_secret.tele_token.id
  secret_data = var.secret_data
}

# Step 3: Create a service account
resource "google_service_account" "service_account" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
}

# Grant access to the Secret Manager
resource "google_project_iam_member" "secret_manager_access" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

# Grant access to the KMS key
resource "google_kms_crypto_key_iam_member" "crypto_key_access" {
  crypto_key_id = google_kms_crypto_key.crypto_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${google_service_account.service_account.email}"
}