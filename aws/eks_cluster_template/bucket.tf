resource "aws_s3_bucket" "bucket" {
  bucket = "<<connections_s3_bucket>>"
  
  tags = {
    Environment = "<<connections_s3_environment_tag>>"
    terraformed = true
  }
}
