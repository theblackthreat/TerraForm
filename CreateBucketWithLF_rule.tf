provider "aws"{
region="us-west-2"
}

resource "aws_s3_bucket" "tbt-tf-01" { 
bucket = "tbt-tf-01" #change bucket name.
acl= "private"


tags = {
Name = "tbt-tf-01" #change bucket tag
}
}
resource "aws_s3_bucket_lifecycle_configuration" "example_bucket_lifecycle" {
  rule {
    id      = "glacier-transition"
    status  = "Enabled"

    transition {
      days          = 60 #change number of days as per the requirement.
      storage_class = "GLACIER"
    }
  }

  bucket = "tbt-tf-01"
}
