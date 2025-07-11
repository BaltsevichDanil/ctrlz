# API Gateway
resource "yandex_api_gateway" "ctrlz_gateway" {
  name        = "ctrlz-gateway"
  description = "API Gateway for CtrlZ microfrontends"
  folder_id   = var.folder_id

  labels = {
    environment = "production"
    project     = "ctrlz"
  }

  spec = yamlencode({
    openapi = "3.0.0"
    info = {
      title   = "CtrlZ Microfrontends Gateway"
      version = "1.0.0"
    }
    
    paths = {
      # Host microfrontend (main application)
      "/" = {
        get = {
          summary = "Host microfrontend"
          operationId = "hostRoot"
          x-yc-apigateway-integration = {
            type = "object_storage"
            bucket = yandex_storage_bucket.ctrlz_fronted_s3_bucket.bucket
            object = "host/latest/index.html"
            presigned_redirect = false
            service_account_id = yandex_iam_service_account.ctrlz_fronted_s3_account.id
          }
        }
      }
      
      # Host microfrontend static assets
      "/host/{proxy+}" = {
        get = {
          summary = "Host microfrontend assets"
          operationId = "hostAssets"
          parameters = [
            {
              name = "proxy"
              in = "path"
              required = true
              schema = {
                type = "string"
              }
            }
          ]
          x-yc-apigateway-integration = {
            type = "object_storage"
            bucket = yandex_storage_bucket.ctrlz_fronted_s3_bucket.bucket
            object = "host/latest/{proxy}"
            presigned_redirect = false
            service_account_id = yandex_iam_service_account.ctrlz_fronted_s3_account.id
          }
        }
      }
      
      # Auth microfrontend
      "/auth/{proxy+}" = {
        get = {
          summary = "Auth microfrontend"
          operationId = "authMicrofrontend"
          parameters = [
            {
              name = "proxy"
              in = "path"
              required = true
              schema = {
                type = "string"
              }
            }
          ]
          x-yc-apigateway-integration = {
            type = "object_storage"
            bucket = yandex_storage_bucket.ctrlz_fronted_s3_bucket.bucket
            object = "auth/latest/{proxy}"
            presigned_redirect = false
            service_account_id = yandex_iam_service_account.ctrlz_fronted_s3_account.id
          }
        }
      }
    }
  })
}