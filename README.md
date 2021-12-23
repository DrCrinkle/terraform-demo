# terraform-demo

This is a terraform project that will set up a VPC with 3 public and 3 private subnets on AWS and create a load balanced website with web servers running NGINX hosted in private subnets. The website itself is hosted on an EFS which is mounted on the web servers.  There is a sample tfvars file in ```config/``` if you would like to test it out. :)

# instructions
```
git clone https://github.com/DrCrinkle/terraform-demo.git
cd terraform-demo
terraform init
terraform apply -var-file=./config/sample.tfvars
```
