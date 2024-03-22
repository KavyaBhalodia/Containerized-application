//Jenkinfile
pipeline{
    agent any
    stages{
        stage('build'){
            steps{
                script{
                def actualCommit = env.ghprbActualCommit
                echo "${actualCommit}"
                }
            }
        }
    }
    
}