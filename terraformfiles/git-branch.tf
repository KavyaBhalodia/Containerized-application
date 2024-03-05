#external block to get current git-branch
data "external" "git_branch" {
  program = ["Powershell.exe", "C:\\Users\\Kavya\\OneDrive\\Desktop\\cloud\\Containerized-application\\terraformfiles\\script.ps1"]
}

#local block store current git-branch
locals {
  env = data.external.git_branch.result["branch"]
}
