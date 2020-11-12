resource "aws_instance" "aws-public" {
  count = var.destroy ? 0 : 1

  ami           = data.aws_ami.aws-public.id
  instance_type = var.instance_type

  key_name = aws_key_pair.aws-public.key_name

  subnet_id              = aws_subnet.aws-public.id
  vpc_security_group_ids = [aws_security_group.aws-public.id]

  root_block_device {
    volume_type = "gp2"
    volume_size = var.volume_size

    delete_on_termination = true
    encrypted             = false
  }

  tags = {
    Name = random_id.aws-public.hex
  }
}
