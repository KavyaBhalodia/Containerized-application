# external block to get current git-branch
data "external" "git_branch" {
  program = local.is_windows ? ["Powershell", "powershell.exe -ExecutionPolicy Bypass -File ..\\code\\script.ps1"] : ["bash", "../code/script1.sh"]
}

#local block store current git-branch
locals {
  env = data.external.git_branch.result["branch"] == "develop" ? "dev" : data.external.git_branch.result["branch"] == "main" ? "prod" : data.external.git_branch.result["branch"]
  
}
locals {
  is_windows = length(regexall("^[a-z]:", lower(abspath(path.root)))) > 0
}
output "branch" {
  value = local.env
}
