resource "aws_eip" "aws-public" {
  depends_on = [aws_internet_gateway.aws-public]

  vpc = true

  tags = {
    Name = random_id.aws-public.hex
  }
}

resource "aws_eip_association" "aws-public" {
  count = var.destroy ? 0 : 1

  allocation_id = aws_eip.aws-public.id
  instance_id   = aws_instance.aws-public.*.id[count.index]
}
