variable "bastion-host-name" {
  type = string
  description = "Name of the bastion-host"
}
variable "subnet-id" {
  type = string
}
variable "bastion-host-sg" {
  type = list(string)
}