#..Infra Optimization.

Implementation requirements:

Create the cluster (EC2 instances with load balancer and elastic IP in case of AWS)
Automate the provisioning of an EC2 instance using Ansible or Chef Puppet
Install Docker and Kubernetes on the cluster
Create a new user with permissions to create, list, get, update, and delete pods
Configure application on the pod
Take snapshot of ETCD database
Set criteria such that if the memory of CPU goes beyond 50%, environments automatically get scaled up and configured
