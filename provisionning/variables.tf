variable "region" {
  default = "eu-central-1"
  description = "AWS Region"
}

variable "resources_name" {
  default = "sagemaker-test"
}

variable "tags" {
  default = {
    "Name": "sagemaker-test"
  }
  description = "Applied tags"
}

variable "ec2_instance_type" {
  default = "ml.t2.medium"
}

variable "notebook_platform" {
  default = "notebook-al2-v2" # Jupyter Lab 3, Apache Linux 2
}