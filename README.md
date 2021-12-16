# terraform-demo

This is a terraform project that will set up a VPC with 3 public and 3 private subnets on AWS. There is a sample tfvars file in ```config/``` if you would like to test it out.

# instructions
```
git clone https://github.com/DrCrinkle/terraform-demo.git
cd terraform-demo
terraform init
terraform apply -var-file=./config/sample.tfvars
```
