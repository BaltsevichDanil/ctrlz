resource "yandex_storage_bucket" "ctrlz_fronted_s3_bucket" {
  access_key = yandex_iam_service_account_static_access_key.ctrlz_fronted_s3_account_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.ctrlz_fronted_s3_account_static_key.secret_key

  bucket = "ctrlz-fronted"
  acl    = "private"

  # CORS configuration for microfrontends
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD", "POST", "PUT", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  # Website configuration
  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  # Lifecycle configuration to manage old versions
  lifecycle_rule {
    id      = "cleanup_old_versions"
    enabled = true

    noncurrent_version_expiration {
      days = 30
    }

    abort_incomplete_multipart_upload_days = 7
  }
}