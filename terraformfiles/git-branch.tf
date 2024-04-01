#external block to get current git-branch
data "external" "git_branch" {
  program = ["Powershell.exe", "${path.module}\\script.ps1"]
}

#local block store current git-branch
locals {
  env = data.external.git_branch.result["branch"]
}




