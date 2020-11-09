resource "null_resource" "aws-public-prepare" {
  count = var.destroy ? 0 : 1

  depends_on = [
    aws_eip.aws-public,
    aws_instance.aws-public,
  ]

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_eip.aws-public.public_ip
    private_key = tls_private_key.aws-public.private_key_pem
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.root}/remote-exec/01-basics.sh",
      "${path.root}/remote-exec/02-docker.sh",
    ]
  }
}

resource "null_resource" "aws-public-clone" {
  count = var.destroy ? 0 : 1

  depends_on = [
    aws_eip.aws-public,
    aws_instance.aws-public,
    null_resource.aws-public-prepare,
  ]

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_eip.aws-public.public_ip
    private_key = tls_private_key.aws-public.private_key_pem
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.root}/remote-exec/03-clone.sh",
    ]
  }
}

resource "null_resource" "aws-public-ubuntu" {
  count = (!var.destroy && var.ubuntu) ? 1 : 0

  depends_on = [
    aws_eip.aws-public,
    aws_instance.aws-public,
    null_resource.aws-public-prepare,
    null_resource.aws-public-clone,
  ]

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_eip.aws-public.public_ip
    private_key = tls_private_key.aws-public.private_key_pem
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.root}/remote-exec/04-ubuntu.sh",
    ]
  }
}

resource "null_resource" "aws-public-centos" {
  count = (!var.destroy && var.centos) ? 1 : 0

  depends_on = [
    aws_eip.aws-public,
    aws_instance.aws-public,
    null_resource.aws-public-prepare,
    null_resource.aws-public-clone,
  ]

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_eip.aws-public.public_ip
    private_key = tls_private_key.aws-public.private_key_pem
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.root}/remote-exec/04-centos.sh",
    ]
  }
}

resource "null_resource" "aws-public-redhat" {
  count = (!var.destroy && var.redhat) ? 1 : 0

  depends_on = [
    aws_eip.aws-public,
    aws_instance.aws-public,
    null_resource.aws-public-prepare,
    null_resource.aws-public-clone,
  ]

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_eip.aws-public.public_ip
    private_key = tls_private_key.aws-public.private_key_pem
  }

  provisioner "file" {
    source      = "${path.root}/Makefile.SUBSCRIPTION"
    destination = "/terraform/epiphany-offline/prepare_scripts/redhat-7/Makefile.SUBSCRIPTION"
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.root}/remote-exec/04-redhat.sh",
    ]
  }
}
