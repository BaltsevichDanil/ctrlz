# Security Group for API Gateway
resource "yandex_vpc_security_group" "api_gateway_sg" {
  name        = "ctrlz-api-gateway-sg"
  description = "Security group for API Gateway"
  network_id  = yandex_vpc_network.ctrlz_network.id
  folder_id   = var.folder_id

  # Allow HTTP and HTTPS traffic from anywhere
  ingress {
    description    = "HTTP"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "HTTPS"
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    description    = "All outbound traffic"
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  labels = {
    environment = "production"
    project     = "ctrlz"
    service     = "api-gateway"
  }
}

# Security Group for internal services
resource "yandex_vpc_security_group" "internal_sg" {
  name        = "ctrlz-internal-sg"
  description = "Security group for internal services"
  network_id  = yandex_vpc_network.ctrlz_network.id
  folder_id   = var.folder_id

  # Allow traffic within the VPC
  ingress {
    description    = "Internal VPC traffic"
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["10.0.0.0/16"]
  }

  # Allow all outbound traffic
  egress {
    description    = "All outbound traffic"
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  labels = {
    environment = "production"
    project     = "ctrlz"
    service     = "internal"
  }
} 