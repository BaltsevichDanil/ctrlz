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
            response_headers = {
              "Content-Type" = "text/html; charset=utf-8"
            }
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
            response_headers = {
              "Content-Type" = "{%- if proxy | regex_match('\\.css$') -%}text/css{%- elif proxy | regex_match('\\.js$') -%}application/javascript{%- elif proxy | regex_match('\\.json$') -%}application/json{%- elif proxy | regex_match('\\.svg$') -%}image/svg+xml{%- elif proxy | regex_match('\\.png$') -%}image/png{%- elif proxy | regex_match('\\.jpg$') or proxy | regex_match('\\.jpeg$') -%}image/jpeg{%- elif proxy | regex_match('\\.gif$') -%}image/gif{%- elif proxy | regex_match('\\.ico$') -%}image/x-icon{%- elif proxy | regex_match('\\.woff$') -%}font/woff{%- elif proxy | regex_match('\\.woff2$') -%}font/woff2{%- elif proxy | regex_match('\\.ttf$') -%}font/ttf{%- elif proxy | regex_match('\\.eot$') -%}application/vnd.ms-fontobject{%- elif proxy | regex_match('\\.html$') -%}text/html; charset=utf-8{%- else -%}application/octet-stream{%- endif -%}"
            }
          }
        }
      }
      
      # Auth microfrontend root
      "/auth" = {
        get = {
          summary = "Auth microfrontend root"
          operationId = "authRoot"
          x-yc-apigateway-integration = {
            type = "object_storage"
            bucket = yandex_storage_bucket.ctrlz_fronted_s3_bucket.bucket
            object = "auth/latest/index.html"
            presigned_redirect = false
            service_account_id = yandex_iam_service_account.ctrlz_fronted_s3_account.id
            response_headers = {
              "Content-Type" = "text/html; charset=utf-8"
            }
          }
        }
      }
      
      # Auth microfrontend assets
      "/auth/{proxy+}" = {
        get = {
          summary = "Auth microfrontend assets"
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
            response_headers = {
              "Content-Type" = "{%- if proxy | regex_match('\\.css$') -%}text/css{%- elif proxy | regex_match('\\.js$') -%}application/javascript{%- elif proxy | regex_match('\\.json$') -%}application/json{%- elif proxy | regex_match('\\.svg$') -%}image/svg+xml{%- elif proxy | regex_match('\\.png$') -%}image/png{%- elif proxy | regex_match('\\.jpg$') or proxy | regex_match('\\.jpeg$') -%}image/jpeg{%- elif proxy | regex_match('\\.gif$') -%}image/gif{%- elif proxy | regex_match('\\.ico$') -%}image/x-icon{%- elif proxy | regex_match('\\.woff$') -%}font/woff{%- elif proxy | regex_match('\\.woff2$') -%}font/woff2{%- elif proxy | regex_match('\\.ttf$') -%}font/ttf{%- elif proxy | regex_match('\\.eot$') -%}application/vnd.ms-fontobject{%- elif proxy | regex_match('\\.html$') -%}text/html; charset=utf-8{%- else -%}application/octet-stream{%- endif -%}"
            }
          }
        }
      }
    }
  })
}