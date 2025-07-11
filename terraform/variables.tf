variable "folder_id" {
  type        = string
  description = "ID каталога"
  sensitive   = true
}

variable "cloud_id" {
  type        = string
  description = "ID облака"
  sensitive   = true
}

variable "token" {
  type        = string
  description = "Токен для доступа к облаку"
  sensitive   = true
}

variable "custom_domain" {
  type        = string
  description = "Кастомный домен для API Gateway (необязательно)"
  default     = ""
}

variable "certificate_id" {
  type        = string
  description = "ID сертификата для кастомного домена"
  default     = ""
}