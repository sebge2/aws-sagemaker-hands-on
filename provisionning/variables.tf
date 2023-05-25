variable "region" {
  default = "eu-central-1"
  description = "AWS Region"
}

variable "resources_name" {
  default = "sagemakertest"
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

variable "vpc-cidr" {
  default = "172.168.0.0/16"
}

variable "subnet-public-cidr" {
  default = "172.168.0.0/24"
}

variable "subnet-private-cidr" {
  default = ["172.168.1.0/24", "172.168.2.0/24"]
}