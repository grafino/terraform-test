variable "region" {
  description = "Region where the instance will be created"
}

variable "region_zone" {
  description = "Datacenter where in the region the instance will be created"
}

variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "account_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}
