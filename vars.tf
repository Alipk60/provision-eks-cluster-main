variable "aws_access_key" {
  default = "***********"
}
variable "aws_secret_key" {
  default = "*********"
}
variable "aws_token" {
  default = "FwoGZXIvYXdzELL//////////wEaDGQBm92GCdOiAIOYpCK0AdREnafkN/Nc3iZyIixjXMlpuA7gBEpYhExJStjmVNarV/5GefTC84T4+G9vBEcQpS1KZllCVQ2tAon+4g1F0KuDweF5naYX0R5o9MJsotBqT1FQFuvRy+npwOiWpH8uu28hHvrA/jQpzVLo6/vzX2xjVGvT2YrAWjpR3ioQGAQzocdYhxgYShACCfQDjDPvr5KetQoQaushA/UjCDO5pYDQVN24r+I0EFMXDrY5Pbwn756CjSi/tMGXBjItlM/UaF07Qc8dKlDPJG9HIbTd3fEYB+QjoQ9aA0oNlRXmFPsODjr99VQBCHZA"
}
variable "aws_region" {
  default = "us-east-1"
}
variable "amis" {
  type = map(string)
  default = {
    us-east-1 = "ami-052efd3df9dad4825"
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
variable "instance_count" {
  default = "3"
}
