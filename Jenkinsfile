//Jenkinfile
pipeline{
    agent any
    stages{
        stage('test'){
            steps{
                echo "${env.ghprbSourceBranch}"
                echo "${env.ghprbTargetBranch}"
                echo "${env.sha1}"
            }
        }
    }
    
}