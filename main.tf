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
#provisioner "local-exec" {
#      command = "echo [master nodes] \n${aws_instance.ubuntu.*.public_ip} >> ${var.host_file}"
#    }
}

# Give Terraform cycle
resource "null_resource" "ubuntu" {
  count = length(var.instance_count)

    #config_file = templatefile("${path.module}/sys/etc/mysql/mariadb.conf/galera.cnf", {
     # all_addresses = hcloud_server.galera_node[*].ipv4_address
     # this_address  = hcloud_server.galera_node[count.index].ipv4_address
     # this_id       = hcloud_server.galera_node[count.index].id
  # })

  provisioner "local-exec" {
      command = "echo [master node] >> ${var.host_file}"
    }
  provisioner "local-exec" {
      command = "echo ${element(aws_instance.ubuntu.*.public_ip, count.index)} >> ${var.host_file}"
    }
  provisioner "local-exec" {
      command = "echo [worker node] >> ${var.host_file}"
    }
  provisioner "local-exec" {
      command = "echo ${element(aws_instance.ubuntu.*.public_ip, count.index+1)} >> ${var.host_file}"
    }
  provisioner "local-exec" {
      command = "echo ${element(aws_instance.ubuntu.*.public_ip, count.index+2)} >> ${var.host_file}"
    }
# provisioner "local-exec" {
 #   command = "sleep 120; ansible-playbook -u ubuntu --private-key ./project1.pem -i hosts playbook.yml"
 # }
}
# Create elastic IP and assosiated to instances
resource "aws_eip" "lb" {
     instance = "${element(aws_instance.ubuntu.*.id,count.index)}"
     count    = var.instance_count
     vpc      = true
     tags = {
          Name = "eip-ubuntu-${count.index+1}"
            }
       }
# Create a new load balancer

resource "aws_elb" "bar" {
  name               = "ubuntu-terraform-elb"
  availability_zones = ["us-east-1a"]
  security_groups    = ["${aws_security_group.web_traffic.id}"]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
   }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }
  instances                   = "${aws_instance.ubuntu.*.id}"
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "foobar-terraform-elb"
  }
}

output "ec2_global_ips" {

  value = "${aws_instance.ubuntu.*.public_ip}"

}
