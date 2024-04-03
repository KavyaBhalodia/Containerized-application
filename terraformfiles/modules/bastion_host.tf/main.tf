
# Key_pair for instance
data "aws_key_pair" "kavya" {
  key_name           = "kavya"
  include_public_key = true
}







#Bastion Host for connecting Database
resource "aws_instance" "bastion_host" {
  ami             = "ami-009e46eef82e25fef"
  instance_type   = "t2.micro"
  subnet_id       = var.subnet_id
  security_groups = var.bastion_host_sg
  key_name        = data.aws_key_pair.kavya.key_name
  tags = {
    Name = var.bastion_host_name
  }
}



#Elastic_ip for instance
# data "aws_eip" "bastion_host_eip" {
#   id       = "eipalloc-0f999c6850496ef92"
# }
#Associating eip with instance
# resource "aws_eip_association" "eip_association" {
#   instance_id   = aws_instance.bastion_host.id
#   allocation_id = data.aws_eip.bastion_host_eip.id
# }