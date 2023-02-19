#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install ansible2 -y

echo -e "\n[ansible]" >> /etc/ansible/hosts
echo ${self.private_ip} >> /etc/ansible/hosts

echo -e "\n[jenkins]" >> /etc/ansible/hosts
echo ${aws_instance.jenkins.private_ip} >> /etc/ansible/hosts

echo -e "\n[knodes]" >> /etc/ansible/hosts
echo ${aws_instance.kub.private_ip} >> /etc/ansible/hosts
