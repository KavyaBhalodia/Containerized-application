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
            
                
                     
                     def source_branch = env.ghprbSourceBranch
                    // // git branch: "${source_branch}",
                    // // credentialsId: 'git-credentials',
                    // // url: "${env.github_url}"
                    // checkout scmGit(
                    //     branches: [[name: "${source_branch}"]],
                    //     userRemoteConfigs: [[credentialsId: 'git-credentials',
                    //     url: "${env.github_url}"]])
                    steps {
                // Checkout the repository using Git
                checkout([$class: 'GitSCM', branches: [[name: "${source_branch}"]], 
                          userRemoteConfigs: [[url: "${env.github_url}"]]])
            
                
            }
        }
        stage('run_script')
        {
            steps{
                script{
                    bat'''
                    E:
                    cd test
                    script.bat
                    '''
                }
            }
        }
    }
    
}
