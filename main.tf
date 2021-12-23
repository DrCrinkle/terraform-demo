module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  env          = var.env
}

module "loadbalancer" {
  source       = "./modules/loadbalancer"
  vpc          = module.vpc.vpc_id
  subnets      = module.vpc.public_subnets
}
