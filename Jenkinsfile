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
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'terraform_awscli'
                ]]) {
                    ansiColor('xterm') {
                        sh '''
                            terraform init
                        '''
                    }
                }
            }
        }
        stage('Terraform plan') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'terraform_awscli'
                ]]) {
                    ansiColor('xterm') {
                        sh '''
                            terraform plan
                        '''
                    }
                }
            }
        }
        stage('Terraform Approve') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'terraform_awscli'
                ]]) {
                    ansiColor('xterm') {
                        sh '''
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }
    }
}
