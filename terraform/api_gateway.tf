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
      # Root path - main entry point
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
      
      # Assets directory - for CSS, JS files
      "/assets/{file+}" = {
        get = {
          summary = "Static assets"
          operationId = "assets"
          parameters = [
            {
              name = "file"
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
            object = "host/latest/assets/{file}"
            presigned_redirect = false
            service_account_id = yandex_iam_service_account.ctrlz_fronted_s3_account.id
          }
        }
      }
      
      # Favicon
      "/favicon.ico" = {
        get = {
          summary = "Favicon"
          operationId = "favicon"
          x-yc-apigateway-integration = {
            type = "object_storage"
            bucket = yandex_storage_bucket.ctrlz_fronted_s3_bucket.bucket
            object = "host/latest/favicon.ico"
            presigned_redirect = false
            service_account_id = yandex_iam_service_account.ctrlz_fronted_s3_account.id
          }
        }
      }
      
      # Vite SVG
      "/vite.svg" = {
        get = {
          summary = "Vite SVG"
          operationId = "viteSvg"
          x-yc-apigateway-integration = {
            type = "object_storage"
            bucket = yandex_storage_bucket.ctrlz_fronted_s3_bucket.bucket
            object = "host/latest/vite.svg"
            presigned_redirect = false
            service_account_id = yandex_iam_service_account.ctrlz_fronted_s3_account.id
          }
        }
      }
      
      # Catch-all for SPA routing - return index.html for all other paths
      "/{path+}" = {
        get = {
          summary = "SPA routing fallback"
          operationId = "spaFallback"
          parameters = [
            {
              name = "path"
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
            object = "host/latest/index.html"
            presigned_redirect = false
            service_account_id = yandex_iam_service_account.ctrlz_fronted_s3_account.id
          }
        }
      }
    }
  })
}