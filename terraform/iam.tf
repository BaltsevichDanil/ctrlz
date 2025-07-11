resource "yandex_iam_service_account" "ctrlz_fronted_s3_account" {
  name = "ctrlz-fronted-s3-account"
  description = "Service account for frontend S3"
  folder_id = var.folder_id
  
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.ctrlz_fronted_s3_account.id}"
}

resource "yandex_iam_service_account_static_access_key" "ctrlz_fronted_s3_account_static_key" {
  service_account_id = yandex_iam_service_account.ctrlz_fronted_s3_account.id
  description        = "static access key for object storage"
}