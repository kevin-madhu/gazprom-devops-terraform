data "aws_ami" "amazon_linux_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

#  filter {
#    name = "name"
#    values = ["*amazon-ecs-optimized"]
#  }

#  filter {
#    name = "virtualization-type"
#    values = ["hvm"]
#  }

  #filter {
  #  name = "image-id"
  #  values = ["ami-04fe06897abb31eb5"]
  #}
}

