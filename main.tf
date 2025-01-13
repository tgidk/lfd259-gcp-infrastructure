terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = "add-gcp-project-id-here"
  region  = "northamerica-south1"
  zone    = "northamerica-south1-c"
}

resource "google_compute_network" "vpc_network" {
  name                    = "lfclass"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name                     = "lfclass"
  network                  = google_compute_network.vpc_network.name
  ip_cidr_range            = "10.2.0.0/16"
  region                   = "northamerica-south1"
  private_ip_google_access = false
}

resource "google_compute_firewall" "vpc_firewall" {
  name    = "lfclass"
  network = google_compute_network.vpc_network.name

  # allow all ports and protocols
  allow {
    protocol = "all"
  }

  # allow traffic from anywhere
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_project_metadata" "ssh_keys" {
  metadata = {
    ssh-keys = "${var.username}:${var.public_key}"
  }
}

resource "google_compute_instance" "vm_instances" {
  for_each     = toset(["cp", "worker"])
  name         = each.key
  machine_type = "e2-standard-2"
  tags         = ["k8s", "dev"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 20
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.vpc_subnetwork.name
    access_config {
    }
  }
}
