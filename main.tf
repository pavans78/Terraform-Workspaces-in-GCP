terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = "PROJECT_ID"
  region  = "us-central1"
}
 