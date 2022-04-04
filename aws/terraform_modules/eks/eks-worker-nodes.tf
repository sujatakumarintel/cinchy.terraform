resource "aws_iam_role" "cinchy-iam-role" {
  name = "${var.clustername}-eks-node-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cinchy-node-policy-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.cinchy-iam-role.name
}

resource "aws_iam_role_policy_attachment" "cinchy-role-cni-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.cinchy-iam-role.name
}

resource "aws_iam_role_policy_attachment" "cinchy-role-acr-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.cinchy-iam-role.name
}

resource "aws_eks_node_group" "cinchy-nodes" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.clustername}-eks-node-group"
  node_role_arn   = aws_iam_role.cinchy-iam-role.arn
  subnet_ids      = aws_subnet.cinchy[*].id
  disk_size       = "${var.disk_size}"
  instance_types  = [ "${var.instancetype}" ]
  remote_access {
    ec2_ssh_key = "${var.clustername}"
    source_security_group_ids = [aws_security_group.cinchy-securitygroup.id] #    source_security_group_ids = [aws_security_group_rule.cinchy-cluster-ingress-workstation-https.source_security_group_id]
  }

  scaling_config {
    desired_size = 3
    max_size     = 6
    min_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.cinchy-node-policy-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.cinchy-role-cni-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.cinchy-role-acr-AmazonEC2ContainerRegistryReadOnly,
  ]
}
