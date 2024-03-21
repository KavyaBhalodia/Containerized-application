//Jenkinfile
pipeline{
    agent any
    stages{
        stage('build'){
            steps{
                script{
                
                //echo "${env.BUILD_NUMBER}"
                echo %env.ghprbSourceBranch% 
                //echo ${env.sha1}
                //echo "${env.BRANCH_NAME}"
                }
                
            }
        }
    }
    
}