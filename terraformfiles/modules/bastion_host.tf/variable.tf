variable "bastion_host_name" {
  type = string
  description = "Name of the bastion_host"
}
variable "subnet_id" {
  type = string
}
variable "bastion_host_sg" {
  type = list(string)
}