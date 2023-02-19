#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install ansible2 -y

echo -e "\n[ANSIBLE]" >> /etc/ansible/hosts
echo ${self.private_ip} >> /etc/ansible/hosts

echo -e "\n[JENKINS]" >> /etc/ansible/hosts
echo ${aws_instance.jenkins.private_ip} >> /etc/ansible/hosts

echo -e "\n[KUBERNETES]" >> /etc/ansible/hosts
echo ${aws_instance.kub.private_ip} >> /etc/ansible/hosts
