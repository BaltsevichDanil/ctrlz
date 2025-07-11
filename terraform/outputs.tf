output "ctrlz_fronted_s3_account_access_key" {
  description = "Access Key ID for S3 bucket"
  value       = yandex_iam_service_account_static_access_key.ctrlz_fronted_s3_account_static_key.access_key
  sensitive   = true
}

output "ctrlz_fronted_s3_account_secret_key" {
  description = "Secret Access Key for S3 bucket"
  value       = yandex_iam_service_account_static_access_key.ctrlz_fronted_s3_account_static_key.secret_key
  sensitive   = true
}

output "ctrlz_fronted_s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = yandex_storage_bucket.ctrlz_fronted_s3_bucket.bucket
}

output "ctrlz_fronted_s3_bucket_domain" {
  description = "Domain name of the S3 bucket"
  value       = yandex_storage_bucket.ctrlz_fronted_s3_bucket.bucket_domain_name
}