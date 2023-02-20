resource "aws_instance" "ansible" {
  ami = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.finava-public-1.id}"
  vpc_security_group_ids = [ aws_security_group.allow-ssh.id ]
  user_data = <<-EOT
    #!/bin/bash

    echo -e "\n[ansible]" >> ~ec2-user/inventory.txt
    echo localhost >> ~ec2-user/inventory.txt

    echo -e "\n[jenkins]" >> ~ec2-user/inventory.txt
    echo ${aws_instance.jenkins.private_ip} >> ~ec2-user/inventory.txt

    echo -e "\n[knodes]" >> ~ec2-user/inventory.txt
    echo ${aws_instance.kube.private_ip} >> ~ec2-user/inventory.txt
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

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install ansible2 -y",
      "sudo yum install git -y",
      "git clone git@github.com:kevin-madhu/gazprom-devops-ansible.git ~/gazprom-devops-ansible",
      "nohup ansible-playbook -i ~/inventory.txt ~/gazprom-devops-ansible/setup-cluster.yml > ~ec2-user/setup-cluster.log &"
    ]    
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
