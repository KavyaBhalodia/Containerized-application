// // Jenkinsfile
// def aws_credentials = {
//     steps{
//         withCredentials([[
//                     $class: 'AmazonWebServicesCredentialsBinding', 
//                     credentialsId:"aws-credential",
//                     ]]){}      
//     }
// } 

// pipeline{
//     agent any
//     stages{
//         stage('checkout'){
//             steps{
//                 script{
//                 //git branch: "${params.branch.split('/').last()}", 
//                 def branch='test'
//                 git branch: "${branch}",
//                 credentialsId: 'git-credentials',
//                 url: "${env.github_url}"
//                 }


//             }
//         } 
//     //   stage('terraform destroy'){
//     //         steps{
//     //             script{
//     //                 aws_credentials(){
//     //                 bat'''
//     //                 cd terraformfiles
//     //                 terraform destroy -auto-approve
//     //                 '''
//     //                 }   
//     //             }
//     //         }
//     //   }
//     //     stage('terraform init'){
//     //         steps{
//     //             script{
//     //                 bat'''
//     //                 cd terraformfiles
//     //                 terraform init
//     //                 '''
//     //             }
//     //         }
//     //     }
//     //     stage('terraform plan'){
//     //         steps{
//     //             script{
//     //                 aws_credentials(){
//     //                 bat'''
//     //                 cd terraformfiles
//     //                 terraform plan 
//     //                 '''
//     //                 }
//     //             } 
//     //         }
//     //     }
//     //     stage('terraform apply'){
//     //         steps{
//     //             script{
//     //                 if("${branch}" == 'main'){
//     //                 aws_credentials
//     //                 {
//     //                 bat'''
//     //                 terraform apply -auto-approve
//     //                 '''
//     //                 }
//     //             }
//     //         }
//     //     }   
//     // }
// }
// }
pipeline{
    agent any
    stages{
        stage('build'){
            steps{
                script{
                def source_branch = env.ghprbSourceBranch
                def target_branch = env.ghprbTargetBranch
                def pull_id=env.ghprbPullId
                def commit_author=env.ghprbActualCommitAuthor
                def commit_author_email=env.ghprbActualCommitAuthorEmail
                echo "${source_branch}"
                echo "${target_branch}"
                echo "${pull_id}"
                echo "${commit_author}"
                echo "${commit_author_email}"
                }
            }
        }
    }
}