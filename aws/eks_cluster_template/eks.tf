module "main" {
  source = "../../terraform_modules/eks"
  region = "<<aws_region>>"
  clustername = "<<cluster_name>>"
  vpnsecuritygroup = "<<vpnsecuritygroup>>"
  vpc_id = "<<vpc_id>>"
  subnet = <<subnet>>
  instancetype = "<<instancetype>>"
  disk_size = "<<disk_size>>"
  usermapping = <<usermapping>>
}