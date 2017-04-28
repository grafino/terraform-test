### Terraform to provision in Azure Resource Manager (ARM)

- First Azure test

#### Getting Started

These instructions will get you started running terraform on Azure. See terraform documentation for much more options on provisioning resources.

#### Prerequisites

* Terraform installed
* Credentials configured on "azure.credentials" file
  * subscription_id
  * client_id      
  * client_secret  
  * tenant_id

```
terraform plan -var-file=azure.credentials
terraform apply -var-file=azure.credentials
terraform destroy -var-file=azure.credentials
```

#### How to obtain and configure credentials

- Microsoft Azure Platform has two different API/Layouts, the Azure legacy and the Azure resource manager AKA azurerm.
- To configure the credentials we must follow the instructions provided on terraform website plus adding a role to the registered App.
- Once completed you will have 3 GUIDs and one key to use for authentication with Azure.

##### azure.credentials example file:
```
az_subscription_id = "xyzxyzxy-xyzz-xyzz-xyzz-xyzxyzxyzxyz"
az_client_id       = "xyzxyzxy-xyzz-xyzz-xyzz-xyzxyzxyzxyz"
az_client_secret   = "xyzxyzxyzxyzxyzxyzxyzxyzxyzxyzxyzxyz="
az_tenant_id       = "xyzxyzxy-xyzz-xyzz-xyzz-xyzxyzxyzxyz"
```
