#Bastion Host for connecting Database
resource "aws_instance" "bastion-host" {
  provider        = aws.sandbox
  ami             = "ami-0895022f3dac85884"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public-subnet[0].id
  security_groups = [aws_security_group.bastion-host-sg.id]
  key_name        = data.aws_key_pair.kavya.key_name
  tags = {
    Name = "kavya-bastion-host"
  }

}

#Key-pair for instance
data "aws_key_pair" "kavya" {
  provider           = aws.sandbox
  key_name           = "kavya"
  include_public_key = true
}

#Elastic-ip for instance
data "aws_eip" "bastion-host-eip" {
  provider = aws.sandbox
  id       = "eipalloc-0afc5bb58a53d930b"
}

#Associating eip with instance
resource "aws_eip_association" "eip-association" {
  provider      = aws.sandbox
  instance_id   = aws_instance.bastion-host.id
  allocation_id = data.aws_eip.bastion-host-eip.id
}