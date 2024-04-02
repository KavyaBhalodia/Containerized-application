#external block to get current git-branch
data "external" "git_branch" {
  program = ["Powershell", "powershell.exe -ExecutionPolicy Bypass -File script.ps1"]
}

#local block store current git-branch
locals {
  env = data.external.git_branch.result["branch"]
}



output "branch" {
  value = "${local.env}"
}


