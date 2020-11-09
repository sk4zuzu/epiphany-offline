resource "random_id" "aws-public" {
  prefix      = "${var.env_name}-"
  byte_length = 4
}
