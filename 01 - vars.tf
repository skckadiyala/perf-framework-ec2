variable "AWS_REGION" {
  default = "us-west-2"
}

variable "PRIVATE_KEY_PATH" {
  default = "falcons-apigw-key-pair"
}

variable "PUBLIC_KEY_PATH" {
  default = "falcons-apigw-key-pair.pub"
}

variable "EC2_USER" {
  default = "ubuntu"
}

variable "AMI" {
  type = map(string)

  default = {
    us-west-2 = "ami-0ae09f90b9f329450"
    eu-west-2 = "ami-03dea29b0216a1e03"
    us-east-1 = "ami-0c2a1acae6667e438"
  }
}

