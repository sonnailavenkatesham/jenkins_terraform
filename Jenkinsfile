pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {

        stage('Check and Install AWS CLI') {
            steps {
                script {
                    def awsInstalled = sh(
                        script: 'which aws',
                        returnStatus: true
                    ) == 0

                    if (!awsInstalled) {
                        echo 'AWS CLI not found. Installing...'
                        sh '''
                            curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                            unzip awscliv2.zip
                            sudo ./aws/install
                        '''
                    } else {
                        echo 'AWS CLI already installed.'
                    }
                }
            }
        }

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
                        terraform plan
                    '''
                }
            }
        }
    }
}
