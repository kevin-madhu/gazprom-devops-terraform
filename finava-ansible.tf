resource "aws_instance" "ansible" {
  ami           = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.finava-public-1.id}"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  user_data = file("scripts/install_ansible.sh")
  key_name = "finava-keypair"  

  tags = {
    Name = "finava-ansible-machine"
  }

 provisioner "file" {
   source = "var.ansible_private_key_path"
   destination = "/home/ec2-user/.ssh/id_ed25519"
 }

  provisioner "file" {
   source = "var.ansible_public_key_path"
   destination = "/home/ec2-user/.ssh/id_ed25519.pub"
 }

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
  connection {
    host = coalesce(self.public_ip, self.private_ip)
    type = "ssh"
    user = "ec2-user"
    private_key = file(var.private_key_path)
  }
}
