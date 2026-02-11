pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Run Terraform') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'terraform_awscli'
                ]]) {
                    sh '''
                        terraform -version
                        aws sts get-caller-identity
                        terraform init
                        terraform plan
                    '''
                }
            }
        }
    }
}
