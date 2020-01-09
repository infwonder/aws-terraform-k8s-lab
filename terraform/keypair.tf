resource "aws_key_pair" "vagrant" {
  key_name = "vagrant"
  public_key = var.VAGRANTBOX_SSH_PUBKEY
}

