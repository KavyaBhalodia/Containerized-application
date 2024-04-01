def  aws_credentials(){
     withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding', 
                    credentialsId:"aws-credential",
                    ]]){}
    
}
                    
pipeline{
    agent any
    stages{
        stage('git checkout')
        {
            steps{
                script{
                    def BRANCH_NAME = "${GIT_BRANCH.split("/")[1]}"
                    echo "${BRANCH_NAME}"
                    git branch: "${BRANCH_NAME}", 
                    credentialsId: 'git-credentials',
                    url: "${env.github_url}"
                }
            }
        }
      stage('terraform destroy'){
            steps{
                script{
                    
                    aws_credentials{
                    
                    aws s3 ls
                    cd terraformfiles
                    terraform destroy -auto-approve
                    
                        
                    }
                    
            }
        }
      }


    //     stage('terraform init'){
    //         steps{
    //             script{
    //                 def BRANCH_NAME = "${GIT_BRANCH.split("/")[1]}"
    //                 if("${BRANCH_NAME}" != 'main' )
    //                 {
    //                 aws_credentials(){
    //                 bat'''
    //                 cd terraformfiles
    //                 terraform init -reconfigure
    //                 '''
    //                 }
    //                 }
    //             }
    //         }
    //     }
    //     stage('terraform plan'){
    //         steps{
    //             script{
    //                 def BRANCH_NAME = "${GIT_BRANCH.split("/")[1]}"
    //                 if("${BRANCH_NAME}" != 'main' )
    //                 {
    //                 aws_credentials(){
    //                 bat'''
    //                 cd terraformfiles
    //                 terraform plan 
    //                 '''
    //                 }
    //                 }
    //             }
    //         }
    //     }
    //     stage('terraform apply'){
    //         steps{
    //             script{

                   
    //                 aws_credentials(){
    //                 bat'''
    //                 terraform apply -auto-approve
    //                 '''
                    
    //             }
    //         }
    //     }
        
    // }
    }
}

