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

                        terraform init
                        terraform fmt
                        terraform validate
                        terraform plan
                    '''
                }
            }
        }
    }
}
