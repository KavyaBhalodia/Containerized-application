#Bastion Host for connecting Database
resource "aws_instance" "bastion-host" {
  ami             = "ami-0895022f3dac85884"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public-subnet[0].id
  security_groups = [aws_security_group.bastion-host-sg.id]
  key_name        = data.aws_key_pair.kavya.key_name
  tags = {
    Name = "${local.env}-kavya-bastion-host"
  }
  provider = aws.sandbox
}

#Key-pair for instance
data "aws_key_pair" "kavya" {
  provider           = aws.sandbox
  key_name           = "kavya"
  include_public_key = true
}

# Elastic-ip for instance
# data "aws_eip" "bastion-host-eip" {
#   id       = "eipalloc-028a33c3884713c4d"
#   provider = aws.sandbox
# }

#Associating eip with instance
# resource "aws_eip_association" "eip-association" {
#   instance_id   = aws_instance.bastion-host.id
#   allocation_id = data.aws_eip.bastion-host-eip.id
#   provider      = aws.sandbox
# }