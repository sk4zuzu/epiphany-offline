output "_ip" {
  value = aws_eip.aws-public.public_ip
}

output "_ssh" {
  value = "ssh -i ${abspath(local_file.aws-public-id_rsa.filename)} ubuntu@${aws_eip.aws-public.public_ip}"
}

output "ubuntu" {
  value = {
    custom_repository_url         = (!var.destroy && var.ubuntu) ? "http://${aws_eip.aws-public.public_ip}:8080/epirepo" : ""
    custom_image_registry_address = (!var.destroy && var.ubuntu) ? "${aws_eip.aws-public.public_ip}:5000" : ""
  }
}

output "centos" {
  value = {
    custom_repository_url         = (!var.destroy && var.centos) ? "http://${aws_eip.aws-public.public_ip}:8081/epirepo" : ""
    custom_image_registry_address = (!var.destroy && var.centos) ? "${aws_eip.aws-public.public_ip}:5001" : ""
  }
}

output "redhat" {
  value = {
    custom_repository_url         = (!var.destroy && var.redhat) ? "http://${aws_eip.aws-public.public_ip}:8082/epirepo" : ""
    custom_image_registry_address = (!var.destroy && var.redhat) ? "${aws_eip.aws-public.public_ip}:5002" : ""
  }
}
