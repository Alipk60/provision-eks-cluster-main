resource "aws_instance" "ubuntu" {
  count         = var.instance_count
  ami           = var.amis[var.aws_region]
  instance_type = "t2.micro"
  key_name      = var.private_key_name
  vpc_security_group_ids = ["${aws_security_group.web_traffic.id}"]
  tags = {
     Name = "ubuntu-${count.index}"
          }
  connection {
    type        = "ssh"
    host        = self.public_ip
    private_key = file(var.path_to_private_key)
    user        = var.instance_username
  }
}

# Give Terraform cycle
 resource "null_resource" "ubuntu3" {
   count = length(var.instance_count)
   depends_on = [aws_eip.lb , aws_elb.bar]
  provisioner "local-exec" {
      command = "echo [master] >> ${var.host_file}"
    }
  provisioner "local-exec" {
      command = "echo ${element(aws_eip.lb.*.public_ip, count.index)} >> ${var.host_file}"
    }
  provisioner "local-exec" {
      command = "echo [worker] >> ${var.host_file}"
    }
  provisioner "local-exec" {
      command = "echo ${element(aws_eip.lb.*.public_ip, count.index+1)} >> ${var.host_file}"
    }
  provisioner "local-exec" {
      command = "echo ${element(aws_eip.lb.*.public_ip, count.index+2)} >> ${var.host_file}"
    }
 # provisioner "local-exec" {
 #   command = "sleep 320; ansible-playbook -u ubuntu --private-key ./project1.pem -i hosts install-docker-kube.yml"
 # }
 }
output "ec2_global_ips" {
  value = "${aws_eip.lb.*.public_ip}"
}
