resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

locals {

  s3_bucket_name = "${var.bucket_name_prefix.stag}-${random_integer.rand.result}"
}


resource "aws_s3_bucket" "bucket" {
  bucket = local.s3_bucket_name
  acl    = "private"

}