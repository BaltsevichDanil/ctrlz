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