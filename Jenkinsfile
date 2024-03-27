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
                echo "${source_branch}"
                echo "${target_branch}"
                echo "${pull_id}"
                }
            }
        }
        stage('checkout')
        {   
                steps {
                script{
                  
                    dir("E:")
                     {
                        bat'''
                        git checkout dev
                        '''

                    // def source_branch = env.ghprbSourceBranch
                    // git branch: "${source_branch}",
                    // credentialsId: 'git-credentials',
                    // url: "${env.github_url}"
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
