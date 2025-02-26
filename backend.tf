terraform {
  backend "gcs" {
    bucket = "gcs-cicd-backend-test"
    prefix = "1-folders"
  }
}  