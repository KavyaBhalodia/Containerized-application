variable "region" {
    type = string
    default ="ap-south-1"
}
variable "az" {
  type = list(string)
  default = [ "ap-south-1a", "ap-south-1b" ]
}