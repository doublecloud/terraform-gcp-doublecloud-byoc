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
      condition     = var.create_project && var.project_name != "" && var.billing_account != "" && var.activate_google_apis
      error_message = "project_name and billing_account must be set and activate_google_apis must be true when create_project is true"
    }
  }
}

locals {
  # await project creation if need
  tmp_project = var.create_project ? google_project.project[0].project_id : var.project_id

  # await APIs activation if need 
  project_id = (local.tmp_project != "" && var.activate_google_apis ? alltrue([for api in local.google_apis : (google_project_service.apis[api].id != "")]) : true) ? local.tmp_project : ""
}

resource "google_project_service" "apis" {
  for_each = local.apis_to_activate

  project = local.tmp_project
  service = each.value
}
