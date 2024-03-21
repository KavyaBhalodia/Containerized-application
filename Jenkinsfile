//Jenkinfile
pipeline{
    agent any
    stages{
        stage('test'){
            steps{
                script{
                bat'''
                echo "${env.ghprbTargetBranch}"
                echo "${env.ghprbSourceBranch}"
                echo "${env.sha1}"
                '''
                }
            }
        }
    }
    
}