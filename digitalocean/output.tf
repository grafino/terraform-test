# Two diferent ways to output list when creating more than one vm

output "Name" {
  value = ["${digitalocean_droplet.grafino_tf.*.name}"]
}

# Another alternative output format
#
# output "Public ip" {
#   value = "${join(",", digitalocean_droplet.grafino_tf.*.ipv4_address)}"
# }

output "Public Ip" {
  value = ["${digitalocean_droplet.grafino_tf.*.ipv4_address}"]
}
