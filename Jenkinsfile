pipeline {
    agent any

    stages {
        stage('Run Terraform Commands') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'terraform_awscli'
                ]]) {
                    ansiColor('xterm') {
                        echo "AWS_CLI configured"
                    }
                }
            }
        }
        stage('Terraform init') {
            steps {
                ansiColor('xterm') {
                    sh '''
                        terraform inite
                    '''
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                ansiColor('xterm') {
                    sh '''
                        terraform inite
                    '''
                }
            }
        }
        stage('Terraform Approve') {
            steps {
                ansiColor('xterm') {
                    sh '''
                        terraform apply -auto-approve
                    '''
                }
            }
        }  
    }
}
