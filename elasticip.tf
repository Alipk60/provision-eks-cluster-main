# Create elastic IP and assosiated to instances
resource "aws_eip" "lb" {
     depends_on = [aws_instance.ubuntu]
     instance = "${element(aws_instance.ubuntu.*.id,count.index)}"
     count    = var.instance_count
     vpc      = true
     tags = {
          Name = "eip-ubuntu-${count.index+1}"
            }
       }
