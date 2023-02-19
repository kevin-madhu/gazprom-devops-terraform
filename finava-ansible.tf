resource "aws_instance" "ansible" {
  ami           = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.finava-public-1.id}"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  tags = {
    Name = "finava-ansible-machine"
  }

#  provisioner "file" {
#    source = "scripts/install_ansible.sh"
#    destination = "/tmp/install_ansible"
#  }

#  provisioner "remote-exec" {
#    inline = [
#      "chmod +x /tmp/install_ansible.sh",
#      "/tmp/install_ansible.sh"
#    ]
#  }

#  connection {
#    host = coalesce(self.public_ip, self.private_ip)
#    type = "ssh"
#  }
  user_data = file("scripts/install_ansible.sh")

  key_name = "finava-keypair"  
}

