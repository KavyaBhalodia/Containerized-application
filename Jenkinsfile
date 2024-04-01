// def  aws_credentials = {
//      withCredentials([[
//                     $class: 'AmazonWebServicesCredentialsBinding', 
//                     credentialsId:"aws-credential",
//                     ]]){
                        
//                     }
    
// }
                    
// pipeline{
//     agent any
//     stages{ 
//       stage('terraform destroy'){
//             steps{
//                 script{
//                     def BRANCH_NAME = "${GIT_BRANCH.split("/")[1]}"
//                     echo "${BRANCH_NAME}"
//                     aws_credentials(){
//                     bat'''
//                     terraform destroy -auto-approve
//                     '''
                        
//                     }
                    
//             }
//         }
//       }


//         stage('terraform init'){
//             steps{
//                 script{
                
//                     aws_credentials(){
//                     bat'''
//                     cd terraformfiles
//                     terraform init -reconfigure
//                     '''
//                     }
//                 }
//             }
//         }
//         stage('terraform plan'){
//             steps{
//                 script{
//                     aws_credentials(){
//                     bat'''
//                     cd terraformfiles
//                     terraform plan 
//                     '''
//                     }
//                 }
//             }
//         }
//         stage('terraform apply'){
//             steps{
//                 script{
//                     if("${branch}" == 'dev'){
//                     aws_credentials(){
//                     bat'''
//                     terraform apply -auto-approve
//                     '''
//                     }
//                 }
//             }
//         }
        
//     }
//     }
// }

pipeline{
    agent any
    stages{ 
      stage('email'){
            steps{
                script{
                    def email=env.CHANGE_AUTHOR_EMAIL
                    def id=env.CHANGE_ID
                    echo "${id}"
                    echo "${email}"
                }
            }
    }
}
}