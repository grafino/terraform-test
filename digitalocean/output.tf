# Two diferent ways to output list when creating more than one vm

output "Name" {
  value = ["${digitalocean_droplet.grafino_tf.*.name}"]
}

output "Public ip" {
  value = "${join(",", digitalocean_droplet.grafino_tf.*.ipv4_address)}"
}
