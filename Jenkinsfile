def  aws_credentials = {
     withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding', 
                    credentialsId:"aws-credential",
                    ]]){
                        
                    }
    
}
                    
pipeline{
    agent any
    stages{ 
      stage('terraform destroy'){
            steps{
                script{
                    aws_credentials{
                    bat'''
                    terraform destroy -auto-approve
                    '''
                        
                    }
                    
            }
        }
      }


        stage('terraform init'){
            steps{
                script{
                    aws_credentials{
                    bat'''
                    cd terraformfiles
                    terraform init -reconfigure
                    '''
                    }
                }
            }
        }
        stage('terraform plan'){
            steps{
                script{
                    aws_credentials{
                    
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
                    withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding', 
                    credentialsId:"aws-credential",
                    ]])
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
