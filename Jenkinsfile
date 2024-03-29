// Jenkinsfile
def aws_credentials = {
    steps{
        withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding', 
                    credentialsId:"aws-credential",
                    ]]){}      
    }
} 

pipeline{
    agent any
    stages{
        stage('checkout'){
            steps{
                script{
                //git branch: "${params.branch.split('/').last()}", 
                def branch='test'
                git branch: "${branch}",
                credentialsId: 'git-credentials',
                url: "${env.github_url}"
                }


            }
        } 
    //   stage('terraform destroy'){
    //         steps{
    //             script{
    //                 aws_credentials(){
    //                 bat'''
    //                 cd terraformfiles
    //                 terraform destroy -auto-approve
    //                 '''
    //                 }   
    //             }
    //         }
    //   }
        stage('terraform init'){
            steps{
                script{
                    bat'''
                    cd terraformfiles
                    terraform init
                    '''
                }
            }
        }
        stage('terraform plan'){
            steps{
                script{
                    aws_credentials(){
                    bat'''
                    cd terraformfiles
                    terraform plan 
                    '''
                    }
                } 
            }
        }
        stage('terraform apply'){
            steps{
                script{
                    if("${branch}" == 'main'){
                    aws_credentials
                    {
                    bat'''
                    terraform apply -auto-approve
                    '''
                    }
                }
            }
        }   
    }
}
}
