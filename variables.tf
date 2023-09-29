variable "ipv4_cidr" {
  type        = string
  description = "Valid IPv4 CIDR block for VPC"
  default     = "10.10.0.0/16"
}

variable "project_id" {
  type        = string
  description = "Project ID where to create resources"
}

variable "project_name" {
  type        = string
  description = "Display name for a new project"
}

variable "folder_id" {
  type        = string
  description = "Folder ID where new project should be created"
  default     = null
}

variable "create_project" {
  type        = bool
  description = "Create new project for DoubleCloud"
  default     = true
}

variable "billing_account" {
  type        = string
  description = "Billing account where new project should be attached"
  default     = ""
}

variable "activate_google_apis" {
  type        = bool
  description = "Activate Google APIs or not"
  default     = true
}

variable "network_name" {
  type        = string
  description = "Network name where create resources"
}

variable "subnetwork_name" {
  type        = string
  description = "Subnetwork name where create resources"
}

variable "region" {
  type        = string
  description = "Region where create resources"
}

variable "service_account_id" {
  type        = string
  description = "Service account ID"
}

variable "service_account_display_name" {
  type        = string
  description = "Display name for service account"
}

variable "role_id" {
  type        = string
  description = "The camel case role ID to create"
}

variable "role_title" {
  type        = string
  description = " A human-readable title for the role"
}
