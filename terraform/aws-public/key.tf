resource "tls_private_key" "aws-public" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "aws-public-id_rsa" {
  filename        = "${path.root}/id_rsa"
  file_permission = "0600"

  content = tls_private_key.aws-public.private_key_pem
}

resource "local_file" "aws-public-id_rsa-pub" {
  filename        = "${path.root}/id_rsa.pub"
  file_permission = "0600"

  content = tls_private_key.aws-public.public_key_openssh
}

resource "aws_key_pair" "aws-public" {
  key_name   = random_id.aws-public.hex
  public_key = tls_private_key.aws-public.public_key_openssh

  tags = {
    Name = random_id.aws-public.hex
  }
}
