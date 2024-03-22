//Jenkinfile
pipeline{
    agent any
    stages{
        stage('build'){
            steps{
                script{
                bat '''
                echo %sha1%
                echo %ghprbSourceBranch%
                '''
                }
            }
        }
    }
    
}