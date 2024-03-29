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
        stage('profile'){
            steps{
                script{
                    aws_credentials(){
                        bat'''
                        aws sts get-caller-identity
                        '''
                    }
                }
            }
        }
    //     stage('checkout'){
    //         steps{
    //             script{
    //             //git branch: "${params.branch.split('/').last()}", 
                
    //             git branch: 'test',
    //             credentialsId: 'git-credentials',
    //             url: "${env.github_url}"
    //             }


    //         }
    //     } 
    // //   stage('terraform destroy'){
    // //         steps{
    // //             script{
    // //                 aws_credentials(){
    // //                 bat'''
    // //                 cd terraformfiles
    // //                 terraform destroy -auto-approve
    // //                 '''
    // //                 }   
    // //             }
    // //         }
    // //   }
    //     stage('terraform init'){
    //         steps{
    //             script{
    //                 bat'''
    //                 cd terraformfiles
    //                 terraform init -reconfigure
    //                 '''
    //             }
    //         }
    //     }
    //     stage('terraform plan'){
    //         steps{
    //             script{
    //                 aws_credentials(){
    //                 bat'''
    //                 cd terraformfiles
    //                 terraform plan 
    //                 '''
    //                 }
    //             } 
    //         }
    //     }
    //     stage('terraform apply'){
    //         steps{
    //             script{
    //                 if("${branch}" == 'main'){
    //                 aws_credentials
    //                 {
    //                 bat'''
    //                 terraform apply -auto-approve
    //                 '''
    //                 }
    //             }
    //         }
    //     }   
    // }
}
}