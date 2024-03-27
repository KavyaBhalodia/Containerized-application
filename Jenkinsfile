//Jenkinfile
pipeline{
    agent any
    stages{
        stage('build'){
            steps{
                script{
                def source_branch = env.ghprbSourceBranch
                def target_branch = env.ghprbTargetBranch
                def pull_id=env.ghprbPullId
                def commit_author=env.ghprbActualCommitAuthor
                def commit_author_email=env.ghprbActualCommitAuthorEmail
                echo "${source_branch}"
                echo "${target_branch}"
                echo "${pull_id}"
                echo "${commit_author}"
                echo "${commit_author_email}"
                }
            }
        }
        stage('checkout')
        {   
                steps {
                script{
                  
                    dir("${env.environment}")
                     {
                    def source_branch = env.ghprbSourceBranch
                    git branch: "${source_branch}",
                    credentialsId: 'git-credentials',
                    url: "${env.github_url}"
                     }

                    }
        }
     }
        stage('run_script')
        {
            steps{
                script{
                    bat'''
                    E:
                    cd script
                    script.bat
                    '''
                }
            }
        }
}
}
