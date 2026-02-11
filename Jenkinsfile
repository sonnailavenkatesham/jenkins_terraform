pipeline {
    agent any

    stages {
        stage('Check and Install Tools') {
            steps {
                script {
                    def awsInstalled = sh(
                        script: 'which aws || true',
                        returnStatus: true
                    ) == 0

                    def terraformInstalled = sh(
                        script: 'which terraform || true',
                        returnStatus: true
                    ) == 0

                    if (!awsInstalled) {
                        echo 'Installing AWS CLI...'
                        sh '''
                            curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                            unzip awscliv2.zip
                            sudo ./aws/install
                        '''
                    } else {
                        echo 'AWS CLI already installed.'
                    }

                    if (!terraformInstalled) {
                        echo 'Installing Terraform...'
                        sh '''
                            curl -O https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_amd64.zip
                            unzip terraform_1.2.9_linux_amd64.zip
                            sudo mv terraform /usr/local/bin/
                        '''
                    } else {
                        echo 'Terraform already installed.'
                    }
                }
            }
        }

        stage('Configure AWS Credentials') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding', 
                    credentialsId: 'terraform_awscli'
                ]]) {
                    echo " AWS Credentials are configured"
                }
            }
        }

        stage('Run Terraform Commands') {
            steps {
                sh '''
                    terraform version
                    aws --version
                '''
                // Your Terraform commands can follow here
            }
        }
    }
}
