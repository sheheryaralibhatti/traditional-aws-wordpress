module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
}

module "subnet" {
  source = "./modules/subnets"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id

}

module "routetables" {
  source = "./modules/routetables"

  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  public_subnets_id  = module.subnet.public_subnets_id
  private_subnets_id = module.subnet.private_subnets_id

}
