output "Name" {
  value = "${aws_instance.grafino_instance.tags.Name}"
}

output "Addresses" {
  value = "${aws_instance.grafino_instance.public_dns}"
}

output "Public Ip's" {
  value = "${aws_instance.grafino_instance.public_ip}"
}
