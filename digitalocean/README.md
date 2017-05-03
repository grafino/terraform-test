#### Terraform to provision in digitalocean

- First test

#### Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

##### Prerequisites

* Terraform installed
* DigitalOcean API Token


#### Credentials



```
terraform plan -var-file=../credentials.tfvars
terraform apply -var-file=../credentials.tfvars
terraform destroy -var-file=../credentials.tfvars
```
