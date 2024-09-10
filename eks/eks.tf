module "eks" {
  -- source  = "terraform-aws-modules/eks/aws"
  -- version = "19.12.0"
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"


  cluster_name    = "${var.service_name}-eks-${var.aws_shot_region}-${var.environment}"
  cluster_version = "1.26"

  vpc_id     = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.network.outputs.cluster_subnets

  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true

  cluster_addons = {
    /*
    coredns = {
      addon_version = "v1.9.3-eksbuild.2"
    }
    kube-proxy = {
      addon_version = "v1.26.2-eksbuild.1"
    }
    vpc-cni = {
      addon_version = "v1.12.6-eksbuild.1"
    }
      */
      coredns = {}
      kube-proxy = {}
      vpc-cni = {}
  }

  cluster_enabled_log_types              = ["audit", "authenticator", "api", "controllerManager", "scheduler"]
  cloudwatch_log_group_retention_in_days = var.log_group_retention

  ## add rule for cluster security group
  cluster_security_group_additional_rules = {
    ingress_gitlab = {
      description = "http from gitlab"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      cidr_blocks = ["100.69.131.0/24"]
    }
  }


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type                               = "AL2_x86_64"
    subnet_ids                             = data.terraform_remote_state.network.outputs.app_subnets
    disk_size                              = 20
    instance_types                         = var.eks_node_instance_types
    update_launch_template_default_version = true
  }

  eks_managed_node_groups = {
    management-node = {
      name            = "${var.environment}-eks-management-node"
      use_name_prefix = false
      ami_type        = "AL2_x86_64"
      platform        = "linux"

      labels = {
        System = "management"
      }

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }


}
