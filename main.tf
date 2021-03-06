module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  env          = var.env
}

module "efs" {
  source         = "./modules/efs"
  subnets        = module.vpc.private_subnets
  security_group = [module.autoscaling.security_group]
}

module "loadbalancer" {
  source       = "./modules/loadbalancer"
  vpc          = module.vpc.vpc_id
  subnets      = module.vpc.public_subnets
}

module "autoscaling" {
  source       = "./modules/autoscaling"
  depends_on   = [
    module.loadbalancer
  ]
  desired      = var.desired
  min          = var.min
  max          = var.max
  vpc          = module.vpc.vpc_id
  subnets      = module.vpc.private_subnets
  target_group = module.loadbalancer.target_group_arn
  elb          = module.loadbalancer.elb
  efs_dns      = module.efs.efs_dns
}

module "route53" {
  source = "./modules/route53"
  depends_on   = [
    module.loadbalancer
  ]
  elb_dns_name = module.loadbalancer.elb_dns_name
}