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
                    def BRANCH_NAME = "${GIT_BRANCH.split("/")[1]}"
                    echo "${BRANCH_NAME}"
                    aws_credentials(){
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
                
                    aws_credentials(){
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
                    if("${branch}" == 'dev'){
                    aws_credentials(){
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
