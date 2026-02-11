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
                            curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                            unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                            chmod +x terraform
                        """

                        // Add current workspace to PATH
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
                        // Ensure workspace terraform is used
                        env.PATH = "${env.WORKSPACE}:${env.PATH}"
                    }

                    sh '''
                        echo "Terraform Version:"
                        terraform version

                        echo "AWS Version:"
                        aws --version

                        echo "Verifying AWS Identity:"
                        aws sts get-caller-identity
                    '''
                }
            }
        }
    }
}
