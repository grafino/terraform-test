provider "google" {
  credentials = "${file(var.account_file_path)}"
  project     = "${var.project_name}"
  region      = "${var.region}"
}

/*resource "google_compute_address" "www" {
    name = "Static Public IP Address"
}*/

resource "google_compute_instance" "test" {
  count        = 1                        // Adjust as desired
  name         = "test${count.index + 1}" // yields "test1", "test2", etc. It's also the machine's name and hostname
  machine_type = "f1-micro"               // smallest (CPU &amp; RAM) available instance
  zone         = "${var.region_zone}"     // yields "europe-west1-d" as setup previously. Places your VM in Europe
  tags         = ["grafino", "terraform"]

  disk {
    image = "centos-7-v20170327" // the operative system (and Linux flavour) that your machine will run
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }
}

resource "google_compute_firewall" "default" {
  name    = "grafino-test-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["grafino-test"]
}
