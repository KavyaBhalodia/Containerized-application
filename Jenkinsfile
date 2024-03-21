//Jenkinfile
pipeline{
    agent any
    stages{
        stage('test'){
            steps{
                echo "${env.ghprbSourceBranch}"
                echo "${ghprbTargetBranch}"
                echo "${sha1}"
            }
        }
    }
    
}