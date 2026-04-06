variable "cors_frontend_addresses" {
  description = "CORS allowed origin for the backend API"
  type        = list(string)
}

variable "postgresql_admin_username" {
  description = "Username for the PostgreSQL administrator account"
  type        = string
}

variable "postgresql_admin_password" {
  description = "Password for the PostgreSQL administrator account"
  type        = string
  sensitive   = true
}

variable "allowed_ips" {
  description = "List of IP addresses allowed to access the PostgreSQL server"
  type        = list(string)
}

variable "aim_users_rg" {
  description = "Name of the resource group containing the AIM users"
  type        = list(string)
} 

variable "tenant_id" {
  description = "Azure Active Directory tenant ID for the subscription"
  type        = string
}

variable "client_id" {
  description = "Client ID of the service principal used by Terraform"
  type        = string
}
