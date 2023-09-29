output "network_name" {
  value       = google_compute_network.byoc.name
  description = "Name of the created Network. DoubleCloud resources will be created in this Network."
}

output "subnetwork_name" {
  value       = google_compute_subnetwork.byoc.name
  description = "Name of the created Subnetwork. DoubleCloud resources will be created in this Subnetwork."
}

output "service_account_email" {
  value       = time_sleep.avoid_gcp_race.triggers["email"]
  description = "Email of the Service Account that has permissions to create resources in the project."
}

output "region_id" {
  value       = var.region
  description = "GCP Region where resources will be created."
}

output "project_name" {
  value       = local.project_id
  description = "GCP project ID where resources will be created."
}
