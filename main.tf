provider "aws" {
  region = "ap-south-1"  # Update to your AWS region
}

resource "aws_eks_cluster" "Ayushmaan_Assessment" {
  name     = "Ayushmaan-Assessment"
  role_arn = "arn:aws:iam::123456789012:role/EKS-Role"  # Hardcoded IAM Role ARN

  vpc_config {
    subnet_ids         = ["subnet-029212482e40715a2", "subnet-05f364415b1f90768"]  # Subnets from default VPC
    security_group_ids = ["sg-07890e923372c06a2"]  # Corrected security group ID
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator"]

  # No depends_on needed since IAM role is outside Terraform
}

resource "aws_eks_node_group" "Ayushmaan-Worker" {
  cluster_name    = aws_eks_cluster.Ayushmaan_Assessment.name
  node_role_arn   = "arn:aws:iam::123456789012:role/EKS-Role"  # Hardcoded IAM Role ARN
  subnet_ids      = ["subnet-029212482e40715a2", "subnet-05f364415b1f90768"]  # Subnets from default VPC

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  instance_types = ["t2.medium"]

  tags = {
    Name = "Ayushmaan-Worker"
  }

  # No depends_on needed here either
}
