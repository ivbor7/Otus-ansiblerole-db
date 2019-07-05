terraform {
  # version of  terraform
  required_version = "0.11.11"
}

provider "google" {
  # provider version
  version = "2.0.0"
 # ID project
  project = "${var.project}"
  region = "${var.region}"
}

resource "google_compute_instance" "app" {
  name = "reddit-app"
  machine_type = "f1-micro"
  zone = "us-central1-a"
  tags = ["reddit-app"]

  metadata {
 # path to ssh public key
  ssh-keys = "appuser:${file("~/.ssh/appuser.pub")}"
}

# boot disk determination
  boot_disk {
    initialize_params {
      image = "reddit-base"
    }
}

# define the network interface
network_interface {

# what network connect to
network = "default"
# use  ephemeral IP to access the Internet
access_config {}
}

connection {
type = "ssh"
user = "appuser"
agent = false
# private key path
#private_key = "${file("~/.ssh/appuser")}"
private_key = "${file(var.private_key_path)}"
}


provisioner "file" {
  source = "files/puma.service"
  destination = "/tmp/puma.service"
}

provisioner "remote-exec" {
  script = "files/deploy.sh"
}

}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

# network name where the firewall rule going be acting
  network = "default"

# what access type allow
  allow {
    protocol = "tcp"
    ports = ["9292"]
  }

# what IP-addresses will be allowed
  source_ranges = ["0.0.0.0/0"]

# The rule will be applied to instances with listed below tags
  target_tags = ["reddit-app"]

}
