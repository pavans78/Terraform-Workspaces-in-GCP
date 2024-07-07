terraform {
  backend "gcs" {
    bucket = "gcs-bucket-79"
    prefix = "terraform-state"
  }
}