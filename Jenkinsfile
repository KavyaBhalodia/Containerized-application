//Jenkinfile
pipeline{
    agent any
    stages{
        stage('build'){
            steps{
                script{
                bat '''
                set var=%sha1%
                echo %var%
                echo %ghprbSourceBranch%
                '''
                }
            }
        }
    }
    
}