output "Name" {
  value = "${aws_instance.grafino_instance.tags.name}"
}

output "public_ip" {
  value = "${aws_instance.grafino_instance.public_ip}"
}
