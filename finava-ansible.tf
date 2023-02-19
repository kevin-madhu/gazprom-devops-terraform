resource "aws_instance" "ansible" {
  ami = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.finava-public-1.id}"
  vpc_security_group_ids = [ aws_security_group.allow-ssh.id ]
  user_data = <<-EOT
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras install ansible2 -y

    echo -e "\n[jenkins]" >> /etc/ansible/hosts
    echo ${aws_instance.jenkins.private_ip} >> /etc/ansible/hosts

    echo -e "\n[knodes]" >> /etc/ansible/hosts
    echo ${aws_instancee.kube.private_ip} >> /etc/ansible/hosts
  EOT

  key_name = "finava-keypair"  
  
  provisioner "file" {
    source = var.internal_private_key_path
    destination = "/home/ec2-user/.ssh/id_ed25519"
  }
   
  provisioner "file" {
    source = var.internal_public_key_path
    destination = "/home/ec2-user/.ssh/id_ed25519.pub"
  }

  connection {
    host = coalesce(self.public_ip, self.private_ip)
    type = "ssh"
    user = "ec2-user"
    private_key = file(var.private_key_path)
  }

  tags = {
    Name = "finava-ansible-machine"
  }
}
