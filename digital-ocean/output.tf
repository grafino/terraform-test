output "Name" {
  value = "${digitalocean_droplet.grafino_tf.name}"
}

output "Public ip" {
  value = "${digitalocean_droplet.grafino_tf.ipv4_address}"
}
