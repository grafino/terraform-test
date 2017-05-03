provider "google" {
  credentials = "${file(var.account_file_path)}"
  project     = "${var.project_name}"
  region      = "${var.region}"
}

# Creates a custom network, similar to VPC on AWS
resource "google_compute_network" "grafino-network" {
  name                    = "grafino-network"
  auto_create_subnetworks = "false"
}

# Creates a custom subnetwork, similar to VPC on AWS
resource "google_compute_subnetwork" "grafino-sub" {
  name          = "grafino-sub"
  ip_cidr_range = "10.15.0.0/16"
  network       = "${google_compute_network.grafino-network.self_link}"
  region        = "${var.region}"
}

# Security Grups to alow ssh
resource "google_compute_firewall" "grafino-rule-ssh" {
  name    = "grafino-rule-ssh"
  network = "grafino-network"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Security Grups to alow ping
resource "google_compute_firewall" "grafino-rule-ping" {
  name    = "grafino-rule-ping"
  network = "grafino-network"

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

# Creates the instance
resource "google_compute_instance" "grafino-instance" {
  count        = 1
  name         = "grafino-server-${count.index + 1}"
  machine_type = "f1-micro"
  zone         = "${var.region_zone}"
  tags         = ["grafino", "terraform", "instance"]

  disk {
    image = "centos-7-v20170327"
  }

  # The network or subnetwork in witch this instance will be running
  network_interface {
    #network = "grafino-network"
    subnetwork = "${google_compute_subnetwork.grafino-sub.name}"

    access_config {
      // Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }
}


# # LATER define default connection for remote provisioners
# connection {
# type = "ssh"
# user = "${var.gce_ssh_user}"
# private_key = "${file(var.gce_ssh_private_key_file)}"
# }
