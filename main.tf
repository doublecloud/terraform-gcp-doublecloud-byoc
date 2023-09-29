resource "google_compute_network" "byoc" {
  name    = var.network_name
  project = local.project_id

  auto_create_subnetworks  = false
  routing_mode             = "REGIONAL"
  enable_ula_internal_ipv6 = true
  mtu                      = 8896
}

resource "google_compute_subnetwork" "byoc" {
  name    = var.subnetwork_name
  network = google_compute_network.byoc.name
  region  = var.region
  project = local.project_id

  ip_cidr_range    = var.ipv4_cidr
  ipv6_access_type = "EXTERNAL"
  stack_type       = "IPV4_IPV6"
}

resource "google_service_account" "byoc" {
  account_id = var.service_account_id
  project    = local.project_id

  display_name = var.service_account_display_name
}

data "google_iam_policy" "access_control" {
  binding {
    members = ["serviceAccount:controlplane@byoa-doublecloud.iam.gserviceaccount.com"]
    role    = "roles/iam.serviceAccountTokenCreator"
  }
}

resource "google_service_account_iam_policy" "byoc" {
  service_account_id = google_service_account.byoc.name
  policy_data        = data.google_iam_policy.access_control.policy_data
}

resource "google_project_iam_custom_role" "byoc" {
  role_id = var.role_id
  project = local.project_id
  title   = var.role_title
  permissions = [
    "cloudkms.cryptoKeyVersions.destroy",
    "cloudkms.cryptoKeyVersions.list",
    "cloudkms.cryptoKeys.create",
    "cloudkms.cryptoKeys.get",
    "cloudkms.cryptoKeys.getIamPolicy",
    "cloudkms.cryptoKeys.setIamPolicy",
    "cloudkms.cryptoKeys.update",
    "cloudkms.keyRings.create",
    "cloudkms.keyRings.get",

    "compute.addresses.createInternal",
    "compute.addresses.deleteInternal",
    "compute.addresses.get",
    "compute.addresses.use",
    "compute.disks.create",
    "compute.disks.resize",
    "compute.firewalls.create",
    "compute.forwardingRules.create",
    "compute.forwardingRules.delete",
    "compute.forwardingRules.pscCreate",
    "compute.forwardingRules.pscDelete",
    "compute.globalOperations.get",
    "compute.images.getFromFamily",
    "compute.images.useReadOnly",
    "compute.instances.create",
    "compute.instances.delete",
    "compute.instances.get",
    "compute.instances.setMetadata",
    "compute.instances.setServiceAccount",
    "compute.instances.start",
    "compute.instances.stop",
    "compute.instances.update",
    "compute.networks.addPeering",
    "compute.networks.create",
    "compute.networks.get",
    "compute.networks.removePeering",
    "compute.networks.updatePolicy",
    "compute.networks.use",
    "compute.regionOperations.get",
    "compute.subnetworks.create",
    "compute.subnetworks.delete",
    "compute.subnetworks.get",
    "compute.subnetworks.use",
    "compute.subnetworks.useExternalIp",
    "compute.zoneOperations.get",

    "dns.changes.create",
    "dns.managedZones.create",
    "dns.networks.bindPrivateDNSZone",
    "dns.resourceRecordSets.create",
    "dns.resourceRecordSets.delete",
    "dns.resourceRecordSets.get",
    "dns.resourceRecordSets.update",

    "iam.serviceAccounts.actAs",
    "iam.serviceAccounts.create",
    "iam.serviceAccounts.delete",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.getIamPolicy",
    "iam.serviceAccounts.list",

    "resourcemanager.projects.get",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.setIamPolicy",

    "servicedirectory.services.create",
    "servicedirectory.services.delete",
    "servicedirectory.namespaces.create",

    "storage.buckets.create",
    "storage.buckets.delete",
    "storage.buckets.get",
    "storage.buckets.getIamPolicy",
    "storage.buckets.setIamPolicy",
    "storage.buckets.update",
    "storage.hmacKeys.create",
    "storage.hmacKeys.delete",
    "storage.hmacKeys.list",
    "storage.hmacKeys.update",
    "storage.objects.get",
    "storage.objects.delete",
    "storage.objects.list",
  ]
}

resource "google_project_iam_member" "byoc" {
  member  = "serviceAccount:${google_service_account.byoc.email}"
  project = local.project_id
  role    = google_project_iam_custom_role.byoc.id
}
