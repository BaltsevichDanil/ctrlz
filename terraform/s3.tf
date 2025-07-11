resource "yandex_storage_bucket" "ctrlz_fronted_s3_bucket" {
  access_key = yandex_iam_service_account_static_access_key.ctrlz_fronted_s3_account_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.ctrlz_fronted_s3_account_static_key.secret_key

  bucket     = "ctrlz-fronted"
  acl        = "private"
}