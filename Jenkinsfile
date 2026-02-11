pipeline {
    agent any

    stages {
        stage('Run Terraform Commands') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'terraform_awscli'
                ]]) {
                    sh '''
                        echo "Terraform Version:"
                        terraform version

                        echo "AWS Version:"
                        aws --version

                        echo "Verifying AWS Identity:"
                        aws sts get-caller-identity

                        echo "Running Terraform Steps:"
                        terraform init
                    '''
                }
            }
        }
    }
}
