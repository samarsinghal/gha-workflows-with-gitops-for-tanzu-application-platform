provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "google" {
  project = var.project
}

variable "project" {
  description = "The target active Google project id"
}

variable "kubeconfig_path" {
  description = "kubeconfig path"
}
