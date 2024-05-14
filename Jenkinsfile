             
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
                    // def BRANCH_NAME = "${GIT_BRANCH.split("/")[1]}"
                    // if("${BRANCH_NAME}" == 'dev')
                    // {
                    bat'''
                    make init
                    '''
                    //}
                }
            }
        }
        // stage('ECR push')
        // {
        //     steps{
        //         script{
        //             bat'''
        //             make ecr_build_push
        //             '''
        //         }
        //     }
        // }
        stage('terraform plan'){
            steps{
                script{
                    bat'''
                    make plan
                    '''
                }
            }
        }
        stage('terraform apply'){
            steps{
                script{
                    bat'''
                    make apply
                    '''
                }
            }
        }
        stage('ECR push')
        {
            steps{
                script{
                    bat'''
                    make ecr_build_push
                    '''
                }
            }
        }
    }    
}


