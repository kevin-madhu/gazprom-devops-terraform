resource "aws_instance" "kube" {
  ami = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.large"
  subnet_id = "${aws_subnet.finava-public-1.id}"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name = "finava-keypair"  

  
  provisioner "file" {
    source = var.internal_private_key_path
    destination = "/home/ec2-user/.ssh/id_ed25519"
  }
   
  provisioner "file" {
    source = var.internal_public_key_path
    destination = "/home/ec2-user/.ssh/id_ed25519.pub"
  }

  provisioner "file" {
    source = "config/sshd_config"
    destination = "/home/ec2-user/.ssh/config"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 ~/.ssh/config",
      "sudo service sshd restart",
      "cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys",
      "chmod 400 ~/.ssh/id_ed25519"
    ]
  }

  connection {
    host = coalesce(self.public_ip, self.private_ip)
    type = "ssh"
    user = "ec2-user"
    private_key = file(var.private_key_path)
  }

  tags = {
    Name = "finava-kube-machine"
  }
}
