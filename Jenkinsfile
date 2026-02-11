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
                        script: 'aws --version',
                        returnStatus: true
                    ) == 0

                    if (!awsInstalled) {
                        echo "AWS CLI not found. Installing locally..."

                        sh """
                            curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                            unzip -o awscliv2.zip
                            ./aws/install --bin-dir ${env.WORKSPACE}/bin --install-dir ${env.WORKSPACE}/aws-cli --update
                        """

                        env.PATH = "${env.WORKSPACE}/bin:${env.PATH}"
                    } else {
                        echo "AWS CLI already installed."
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
