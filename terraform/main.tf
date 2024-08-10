terraform {
  backend "gcs" {
    bucket = "gobot-infra"
    prefix = "terraform/state"
  }
}

module "gke_cluster" {
  source         = "github.com/ihorhrysha/tf-google-gke-cluster"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
  GKE_NUM_NODES  = var.GKE_NUM_NODES
}
