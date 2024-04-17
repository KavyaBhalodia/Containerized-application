variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "AWS default region"
}
variable "az" {
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
  description = "Availability zones that resources will use"
}
