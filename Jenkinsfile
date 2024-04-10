             
pipeline{
    agent any
    environment{
        AWS_ACCESS_KEY_ID = credentials('aws-credential')
        AWS_SECRET_ACCESS_KEY = credentials('aws-credential')
    }
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
        stage('terraform init'){
            steps{
                script{
                    def BRANCH_NAME = "${GIT_BRANCH.split("/")[1]}"
                    if("${BRANCH_NAME}" == 'dev')
                    {
                    bat'''
                    cd terraformfiles
                    make init
                    '''
                    }
                }
            }
        }
        // stage('terraform plan'){
        //     steps{
        //         script{
        //             def BRANCH_NAME = "${GIT_BRANCH.split("/")[1]}"
        //             bat'''
        //             cd terraformfiles
        //             terraform plan 
        //             '''
        //         }
        //     }
        // }
        // stage('terraform apply'){
        //     steps{
        //         script{
        //             bat'''
        //             cd terraformfiles
        //             terraform apply -auto-approve
        //             '''
        //         }
        //     }
        // }
    }    
}

