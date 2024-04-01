//Jenkinfile
pipeline{
    agent any
    stages{
        stage('build'){
            steps{
                script{
                // def source_branch = env.ghprbSourceBranch
                // def target_branch = env.ghprbTargetBranch
                // def pull_id=env.ghprbPullId
                // echo "${source_branch}"
                // echo "${target_branch}"
                // echo "${pull_id}"

                // echo "BRANCH-1"
                    // def commitAuthorEmail = bat(script: 'git log --format=%ae -n 1', returnStdout: true).trim()
                    // echo "Commit Author Email: ${commitAuthorEmail}"
             def COMMITTER_EMAIL = bat (
                script: "git --no-pager show -s --format=%%ae",
                  returnStdout: true
              ).split('\r\n')[2].trim()

    echo "The last commit was written by ${COMMITTER_EMAIL}"

             
                }
            }
        }
    }
    
}