module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  subnet_cidr  = var.subnet_cidr
  subnet2_cidr = var.subnet2_cidr
  subnet3_cidr = var.subnet3_cidr
  subnet4_cidr = var.subnet4_cidr
  subnet5_cidr = var.subnet5_cidr
  subnet6_cidr = var.subnet6_cidr
  env          = var.env
}