resource "aws_instance" "kube" {
  ami           = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"

  tags = {
    Name = "finava-kube-machine"
  }
}

