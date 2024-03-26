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
                    dir("E\\test-1")
                     {
                    def source_branch = env.ghprbSourceBranch
                    git branch: "${source_branch}",
                    credentialsId: 'git-credentials',
                    url: "${env.github_url}"
                     }
                    }
                // script {
                //     // Define the branch name and the target directory
                //     def source_branch = env.ghprbSourceBranch
                //     def targetDirectory = 'E:/test'

                //     // Checkout the branch in the target directory
                //     dir(targetDirectory) {
                //         // Checkout the specific branch
                //         checkout([$class: 'GitSCM', 
                //             branches: [[name: "refs/heads/${source_branch}"]],
                //             userRemoteConfigs: [[url: "${env.github_url}",credentialsId:'git-credentials']]])
                //     }
                // }
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
