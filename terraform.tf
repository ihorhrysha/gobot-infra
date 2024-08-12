terraform {
  backend "gcs" {
    bucket = "gobot-infra"
    prefix = "terraform/state"
  }
}
