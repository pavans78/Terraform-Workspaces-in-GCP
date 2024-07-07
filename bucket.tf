resource "google_storage_bucket" "gcs_bucket" {
  name          = var.bucket_name
  storage_class = "STANDARD"
  location      = "US"
  force_destroy = true
}
