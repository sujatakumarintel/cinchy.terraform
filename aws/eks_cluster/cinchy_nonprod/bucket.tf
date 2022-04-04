resource "aws_s3_bucket" "bucket" {
  bucket = "cinchy-connections-cinchy-nonprod"
  
  tags = {
    Environment = "cinchy_nonprod"
    terraformed = true
  }
}
