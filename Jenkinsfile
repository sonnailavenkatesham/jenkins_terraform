pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        TERRAFORM_VERSION = '1.6.6'
    }

    stages {

        stage('Install Terraform (If Missing)') {
            steps {
                script {
                    def terraformInstalled = sh(
                        script: 'terraform version',
                        returnStatus: true
                    ) == 0

                    if (!terraformInstalled) {
                        echo "Terraform not found. Installing locally..."

                        sh """
                            sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
                            curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -y
                            sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
                            sudo apt-get update && sudo apt-get install terraform -y
                        """

                        env.PATH = "${env.WORKSPACE}:${env.PATH}"
                    } else {
                        echo "Terraform already installed."
                    }
                }
            }
        }

        stage('Run Terraform') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'terraform_awscli'
                ]]) {

                    script {
                        env.PATH = "${env.WORKSPACE}:${env.PATH}"
                    }

                    sh '''
                        terraform version
                        aws sts get-caller-identity
                    '''
                }
            }
        }
    }
}
