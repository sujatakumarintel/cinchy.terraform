resource "aws_iam_role" "cinchy-cluster-role" {
  name = "${var.clustername}-eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "role-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cinchy-cluster-role.name
}

resource "aws_iam_role_policy_attachment" "role-vpc-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cinchy-cluster-role.name
}

resource "aws_security_group" "cinchy-securitygroup" {
  name        = "${var.clustername}-eks-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = data.aws_vpc.cinchy.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.clustername}-eks-sg"
  }
}

resource "aws_security_group_rule" "cinchy-cluster-ingress-workstation-https" {
  source_security_group_id  = var.vpnsecuritygroup
  description               = "Allow workstation to communicate with the cluster API Server"
  from_port                 = 0
  protocol                  = "tcp"
  security_group_id         = aws_security_group.cinchy-securitygroup.id
  to_port                   = 0
  type                      = "ingress"
}

resource "aws_eks_cluster" "cluster" {
  name     = var.clustername
  role_arn = aws_iam_role.cinchy-cluster-role.arn

  vpc_config {
    security_group_ids = [aws_security_group.cinchy-securitygroup.id]
    subnet_ids         = aws_subnet.cinchy[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.role-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.role-vpc-AmazonEKSVPCResourceController,
  ]
}
