//Jenkinfile
pipeline{
    agent any
    stages{
        stage('test'){
            steps{
                echo "${params.ghprbSourceBranch}"
                echo "${env.ghprbTargetBranch}"
                echo "${env.sha1}"
            }
        }
    }
    
}