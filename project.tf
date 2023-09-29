locals {
  google_apis = [
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "deploymentmanager.googleapis.com",
    "dns.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
  ]
  apis_to_activate = var.activate_google_apis ? toset(local.google_apis) : toset([])
}

resource "google_project" "project" {
  count      = var.create_project ? 1 : 0
  name       = var.project_name
  project_id = var.project_id
  folder_id  = var.folder_id

  billing_account = var.billing_account

  lifecycle {
    precondition {
      condition     = var.create_project && var.project_name != "" && var.billing_account != ""
      error_message = "project_name and project_name must be set when create_project is true"
    }
  }
}

locals {
  # await project creation if need 
  project_id = var.create_project ? google_project.project.project_id : var.project_id
}

resource "google_project_service" "apis" {
  for_each = local.apis_to_activate

  project = local.project_id
  service = each.value
}
