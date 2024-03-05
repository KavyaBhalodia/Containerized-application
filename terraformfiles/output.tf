data "external" "git_branch" {
  program = ["Powershell.exe", "C:\\Users\\Kavya\\OneDrive\\Desktop\\cloud\\Containerized-application\\terraformfiles\\script.ps1"]
}
locals {
  
  env = data.external.git_branch.result["branch"]
}
output "git_branch" {
  value = "local.env"
}