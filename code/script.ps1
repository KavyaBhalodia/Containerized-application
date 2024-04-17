$GIT_BRANCH=git rev-parse --abbrev-ref HEAD
Write-Output "{ 
`"branch`": `"$GIT_BRANCH`" 
}"


