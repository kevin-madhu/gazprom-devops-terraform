output "ansible_private_ip" {
  value = aws_instance.ansible.private_ip
}

output "jenkins_private_ip" {
  value = aws_instance.jenkins.private_ip
}

output "kube_private_ip" {
  value = aws_instance.kube.private_ip
}

output "ansible_public_ip" {
  value = aws_instance.ansible.public_ip
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "kube_public_ip" {
  value = aws_instance.kube.public_ip
}
