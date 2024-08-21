variable "google_project" {
  type        = string
  description = "GCP project name"
}

variable "google_region" {
  type        = string
  default     = "us-central1-c"
  description = "GCP region to use"
}

variable "gke_num_nodes" {
  type        = number
  default     = 3
  description = "GKE nodes number"
}

variable "deploy_key_algorithm" {
  type        = string
  default     = "RSA"
  description = "The cryptographic algorithm (e.g. RSA, ECDSA)"
}

variable "github_owner" {
  type        = string
  description = "The GitHub owner"
}

variable "github_token" {
  type        = string
  description = "GitHub personal access token with create repo scope"
}


variable "flux_github_repository" {
  type        = string
  description = "Flux github repository name"
}

variable "flux_github_repository_target" {
  type        = string
  default     = "clusters"
  description = "Flux manifests subfolder"
}
