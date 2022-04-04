module "main" {
  source = "../../terraform_modules/eks"
  region = "ca-central-1"
  clustername = "cinchy_nonprod"
  vpnsecuritygroup = "sg-04a030ee17db87f17"
  vpc_id = "vpc-09c0d15f47e8a9426"
  subnet = ["172.31.132.0/24", "172.31.133.0/24", "172.31.134.0/24"]
  instancetype = "c6i.2xlarge"
  disk_size = "50"
  usermapping = <<USERMAPPING
  mapUsers: |
    - userarn: arn:aws:iam::204393242335:user/karanjot.jaswal@cinchy.com
      username: karanjot.jaswal@cinchy.com
      groups:
        - system:masters
    - userarn: arn:aws:iam::204393242335:user/nitin.jadhav@cinchy.com
      username: nitin.jadhav@cinchy.com
      groups:
        - system:masters
    - userarn: arn:aws:iam::204393242335:user/alvin.ho@cinchy.com
      username: alvin.ho@cinchy.com
      groups:
        - system:masters
    - userarn: arn:aws:iam::204393242335:user/william.trieu@cinchy.com
      username: william.trieu@cinchy.com
      groups:
        - system:masters
    - userarn: arn:aws:iam::204393242335:user/andrew.robinson@cinchy.com
      username: andrew.robinson@cinchy.com
      groups:
        - system:masters
    - userarn: arn:aws:iam::204393242335:user/connor.fowlie@cinchy.com
      username: connor.fowlie@cinchy.com
      groups:
        - system:masters
    - userarn: arn:aws:iam::204393242335:user/bhuvaneshwari.sirsabesan@cinchy.com
      username: bhuvaneshwari.sirsabesan@cinchy.com
      groups:
        - system:masters
USERMAPPING
}