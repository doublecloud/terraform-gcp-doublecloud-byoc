terraform {
  required_version = ">= 1.2.6"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.44.1"
    }
  }
}
