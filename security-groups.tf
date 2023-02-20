#resource "aws_security_group" "alb" {
#  name        = "alb-security-group"
#  description = "controls access to the ALB"
#  vpc_id      = aws_vpc.finava-vpc.id

#  ingress {
#    protocol    = "tcp"
#    from_port   = 443
#    to_port     = 443
#    cidr_blocks = ["0.0.0.0/0"]
#  }

#  egress {
#    protocol    = "-1"
#    from_port   = 0
#    to_port     = 0
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}

# Traffic to the ECS cluster should only come from the ALB
#resource "aws_security_group" "ecs_instance" {
#  name        = "ecs-instance"
#  description = "allow inbound access from the ALB only"
#  vpc_id      = aws_vpc.finava-vpc.id

#  ingress {
#    from_port = 32768
#    to_port = 61000
#    protocol = "tcp"
#    security_groups = [aws_security_group.alb.id]
#  }

#  ingress {
#    from_port = 32768
#    to_port = 61000
#    protocol = "tcp"
#    self = true
#  }

#  egress {
#    protocol    = "-1"
#    from_port   = 0
#    to_port     = 0
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}

resource "aws_security_group" "allow-ssh" {
  name        = "allow-ssh"
  description = "allow inbound ssh access"
  vpc_id      = aws_vpc.finava-vpc.id

#  ingress {
#    from_port = 32768
#    to_port = 61000
#    protocol = "tcp"
#    security_groups = [aws_security_group.alb.id]
#  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    self = true
    cidr_blocks      = ["0.0.0.0/0"] #Dangerous and should be removed
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow-jenkins" {
  name        = "allow-jenkins"
  description = "allow inbound ssh access"
  vpc_id      = aws_vpc.finava-vpc.id

#  ingress {
#    from_port = 32768
#    to_port = 61000
#    protocol = "tcp"
#    security_groups = [aws_security_group.alb.id]
#  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    self = true
    cidr_blocks      = ["0.0.0.0/0"] #Dangerous and should be removed
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    self = true
    cidr_blocks      = ["0.0.0.0/0"] #Dangerous and should be removed
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
