//Jenkinfile
pipeline{
    agent any
    stages{
        stage('test'){
            steps{
                script{
                
                echo ${env.ghprbTargetBranch}
                echo ${env.ghprbSourceBranch}
                echo ${env.sha1}
                
                }
            }
        }
    }
    
}