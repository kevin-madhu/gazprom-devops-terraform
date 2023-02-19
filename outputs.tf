output "ansible_private_ip" {
  value = aws_instance.ansible.private_ip
}

output "jenkins_private_ip" {
  value = aws_instance.jenkins.private_ip
}

output "kub_private_ip" {
  value = aws_instance.kub.private_ip
}

