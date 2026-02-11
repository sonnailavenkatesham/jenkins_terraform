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
                        sh '''
                            terraform version
                            terraform init
                            terraform plan
                        '''
                    }
                }
            }
        }
    }
}
