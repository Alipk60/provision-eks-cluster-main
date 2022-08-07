variable "aws_access_key" {
  default = "ASIAX7HMF2FXMHH5BKIS"
}
variable "aws_secret_key" {
  default = "5WnBXd6GgnHVdp5yxD2bBAhoHZ+XexQ3hmJpjFTX"
}
variable "aws_token" {
  default = "FwoGZXIvYXdzEKn//////////wEaDG0gxv+rjO0UII+6TyK0AYZ0HF+MIPk5OGye6A34V+fUyUzwhlivcWXeL0wgirev7q20D7BHETx5LX79NFhfu5ujUTHdFbk3fJWrs7gXCrJwf7rRMZHg0+K5Pnk2aV/IF01HPyTZ4A/BfWtVz2gNURLfntevT86MDqhRE+5khMlNYcWjXkXi1d64FtAju/3go3x6VcH6KvXa/Njm4LtKcwM+RBffLuxIvXyEpQ8F+A/dmOAqhlep3H2I87Y05iJe6e0btyiRwr+XBjItfu6Zh77fD4WOnN/PGG7CQYFiNx2xVAiNbLS0OSokz+y96ZTewVDd0B2YnXNu"
}
variable "aws_region" {
  default = "us-east-1"
}
variable "amis" {
  type = map(string)
  default = {
    us-east-1 = "ami-04505e74c0741db8d"
  }
}
variable "private_key_name" {
  default = "project1"
}
variable "path_to_private_key" {
  default = "/home/pourtarkigmail/InfraOptimization/project1.pem"
}
variable "path_to_public_key" {
  default = "project1.pub"
}
variable "instance_username" {
  default = "ubuntu"
}
variable "aws_security_group" {
  default = "web_traffic"
}
variable "host_file" {
  default = "hosts"
}
