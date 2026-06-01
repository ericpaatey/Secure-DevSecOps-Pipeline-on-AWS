module "eks" {

  source = "terraform-aws-modules/eks/aws"

  cluster_name = "secure-devsecops-cluster"

  cluster_version = "1.29"

  subnet_ids = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  eks_managed_node_groups = {

    default = {
      desired_size = 2
      min_size     = 2
      max_size     = 4

      instance_types = ["t3.medium"]
    }
  }
}