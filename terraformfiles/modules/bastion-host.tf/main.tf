
#Key-pair for instance
data "aws_key_pair" "kavya" {
  key_name           = "kavya"
  include_public_key = true
}

#Bastion Host for connecting Database
resource "aws_instance" "bastion-host" {
  ami             = "ami-0895022f3dac85884"
  instance_type   = "t2.micro"
  subnet_id       = var.subnet-id
  security_groups = var.bastion-host-sg
  key_name        = data.aws_key_pair.kavya.key_name
  tags = {
    Name = "var.bastion-host-name"
  }
}

#Elastic-ip for instance
data "aws_eip" "bastion-host-eip" {
 
  id       = "eipalloc-028a33c3884713c4d"
}

#Associating eip with instance
resource "aws_eip_association" "eip-association" {
  instance_id   = aws_instance.bastion-host.id
  allocation_id = data.aws_eip.bastion-host-eip.id
}