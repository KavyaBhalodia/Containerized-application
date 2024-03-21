//Jenkinfile
pipeline{
    agent any
    stages{
        stage('test'){
            steps{
                script{
                bat'''
                echo "${env.BRANCH_NAME}"
                echo "${env.ghprbTargetBranch}"
                echo "${env.sha1}"
                '''
                }
            }
        }
    }
    
}