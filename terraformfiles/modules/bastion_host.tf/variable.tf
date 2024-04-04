variable "bastion_host_name" {
  type = string
  description = "Name of the bastion_host"
}
variable "subnet_id" {
  type = string
  description = "Subnet id used in bastion host"
}
variable "bastion_host_sg" {
  type = list(string)
  description = "Security group for bastion host"
}