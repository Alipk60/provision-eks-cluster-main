esource "aws_instance" "ubuntu" {
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
resource "null_resource" "ubuntu" {
  count = length(var.instance_count)
  triggers = {
    #config_file = templatefile("${path.module}/sys/etc/mysql/mariadb.conf/galera.cnf", {
     # all_addresses = hcloud_server.galera_node[*].ipv4_address
     # this_address  = hcloud_server.galera_node[count.index].ipv4_address
     # this_id       = hcloud_server.galera_node[count.index].id
  # })
  }
  provisioner "local-exec" {
      command = "echo ${element(aws_instance.ubuntu.*.public_ip, count.index)} >> ${var.host_file}"
    }

 # provisioner "local-exec" {
 #   command = "sleep 120; ansible-playbook -u ubuntu --private-key ./project1.pem -i hosts playbook.yml"
 # }

}

output "ec2_global_ips" {

  value = "${aws_instance.ubuntu.*.public_ip}"

}
