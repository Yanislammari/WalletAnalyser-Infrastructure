## GLOBAL / AZURE AUTH

variable "tenant_id" {
  description = "Azure Active Directory tenant ID for the subscription"
  type        = string
}

variable "client_id" {
  description = "Client ID of the service principal used by Terraform"
  type        = string
}

## POSTGRESQL

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

## RESOURCE GROUPS / IAM

variable "aim_users_rg" {
  description = "Name of the resource group containing the AIM users"
  type        = list(string)
}

## BACKEND VARIABLES

variable "cors_frontend_addresses" {
  description = "CORS allowed origins for the backend API"
  type        = list(string)
}

variable "secret_key" {
  description = "JWT secret key"
  type        = string
  sensitive   = true
}

variable "token_secret" {
  description = "Additional token secret"
  type        = string
  sensitive   = true
}

variable "b_google_oauth_client_id" {
  description = "Google OAuth client ID for backend"
  type        = string
}

variable "mj_api_key" {
  description = "Mailjet API key"
  type        = string
  sensitive   = true
}

variable "mj_api_secret" {
  description = "Mailjet API secret"
  type        = string
  sensitive   = true
}

variable "mj_sender" {
  description = "Mailjet sender email"
  type        = string
}

variable "azure_blob_storage_connection_string" {
  description = "Azure Blob Storage connection string"
  type        = string
  sensitive   = true
}

variable "azure_blob_storage_container_name_templates" {
  description = "Blob container name for email templates"
  type        = string
}

variable "azure_blob_storage_container_name_uploads" {
  description = "Blob container name for uploads"
  type        = string
}

variable "frontend_url_prod" {
  description = "Frontend production URL"
  type        = string
}

variable "api_marketstack_url" {
  description = "Marketstack API base URL"
  type        = string
}

variable "api_marketstack_key" {
  description = "Marketstack API key"
  type        = string
  sensitive   = true
}

## FRONTEND VARIABLES

variable "backend_base_url" {
  description = "Backend base URL used by frontend"
  type        = string
}

variable "f_google_oauth_client_id" {
  description = "Google OAuth client ID for frontend"
  type        = string
}
