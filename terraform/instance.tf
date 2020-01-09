resource "aws_instance" "terra01" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.medium"
  key_name      = aws_key_pair.vagrant.key_name

  vpc_security_group_ids = var.AWS_SGID_K8S
}

resource "aws_instance" "terra02" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.medium"
  key_name      = aws_key_pair.vagrant.key_name

  vpc_security_group_ids = var.AWS_SGID_OPT
}

resource "aws_instance" "terra03" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.medium"
  key_name      = aws_key_pair.vagrant.key_name

  vpc_security_group_ids = var.AWS_SGID_OPT
}

