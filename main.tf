##################
# Providers config

provider "google" {
  credentials = file(var.json_credential)
  project     = "gke-test-338216"
  region      = "us-central1"
}

data "google_client_config" "default" { }

data "google_container_cluster" "my_cluster" {
  name     = "cluster-1"
  location = "us-central1-c"
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.my_cluster.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate,
  )
}

##################
# Argo Application

resource "kubernetes_manifest" "wp-helm" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind" = "Application"
    "metadata" = {
      "finalizers" = [
        "resources-finalizer.argocd.argoproj.io",
      ]
      "name" = "wp-helm"
      "namespace" = "argocd"
    }
    "spec" = {
      "destination" = {
        "server" = "https://kubernetes.default.svc"
      }
      "project" = "default"
      "source" = {
        "chart" = "wordpress"
        "helm" = {
          "valueFiles" = [
            "values.yaml",
          ]
        }
        "repoURL" = "https://charts.bitnami.com/bitnami"
        "targetRevision" = "12.3.0"
      }
    }
  }
}
