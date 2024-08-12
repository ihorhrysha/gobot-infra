module "gke_cluster" {
  source         = "github.com/ihorhrysha/tf-google-gke-cluster"
  GOOGLE_REGION  = var.google_region
  GOOGLE_PROJECT = var.google_project
  GKE_NUM_NODES  = var.gke_num_nodes
}

module "scm_deploy_key" {
  source    = "github.com/den-vasyliev/tf-hashicorp-tls-keys"
  algorithm = var.deploy_key_algorithm
}

module "flux_github_repository" {
  source                   = "github.com/den-vasyliev/tf-github-repository"
  github_owner             = var.github_owner
  github_token             = var.github_token
  repository_name          = var.flux_github_repository
  public_key_openssh       = module.scm_deploy_key.public_key_openssh
  public_key_openssh_title = "flux"
}

module "flux_bootstrap" {
  source            = "github.com/den-vasyliev/tf-fluxcd-flux-bootstrap"
  github_repository = "${var.github_owner}/${var.flux_github_repository}"
  github_token      = var.github_token
  target_path       = var.flux_github_repository_target
  private_key       = module.scm_deploy_key.private_key_pem
  config_path       = module.gke_cluster.kubeconfig
}