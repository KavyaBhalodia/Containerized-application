//Jenkinfile
pipeline{
    agent any
    stages{
        stage('test'){
            steps{
                echo "${env.BRANCH_NAME}"
                echo "${env.ghprbTargetBranch}"
                echo "${env.sha1}"
            }
        }
    }
    
}