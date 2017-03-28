provider "digitalocean" {
  # You need to set this in your .bashrc
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
  # OR
  # Set the variable value in *.tfvars file
  # variable "do_token" {}
  # token = "${var.do_token}"
}

resource "digitalocean_tag" "grafino" { name = "grafino" }
resource "digitalocean_tag" "teste" { name = "teste" }


resource "digitalocean_droplet" "grafino_tf" {
  # Obtain your ssh_key id number via your account. See Document https://developers.digitalocean.com/documentation/v2/#list-all-keys
  ssh_keys           = [5343154]         # Key example
  image              = "${var.centos}"
  region             = "${var.do_lon1}"
  size               = "512mb"
  private_networking = false
  backups            = false
  ipv6               = false
  name               = "grafino_tf"

  tags = ["${digitalocean_tag.grafino.id}", "${digitalocean_tag.teste.id}"]

 provisioner "remote-exec" {
                            inline = [
                            "export PATH=$PATH:/usr/bin",
                            "echo dummy"
                            ]

  connection {
              type     = "ssh"
              private_key = "${file("/Users/ruigrafino/.ssh/id_rsa")}"
              user     = "root"
              timeout  = "1m"
             }
      }
}

/*resource "digitalocean_domain" "grafino_tf" {
  name       = "www.grafino_tf.com"
  ip_address = "${digitalocean_droplet.grafino_tf.ipv4_address}"
}*/

/*resource "digitalocean_record" "grafino_tf" {
  domain = "${digitalocean_domain.grafino_tf.name}"
  type   = "A"
  name   = "grafino_tf"
  value  = "${digitalocean_droplet.grafino_tf.ipv4_address}"
}*/
