pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION',
            choices: ['plan', 'apply', 'destroy'],
            description: 'Choose Terraform action'
        )
    }

    environment {
        TF_VAR_file = 'users.tfvars'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            when {
                expression { params.ACTION == 'plan' }
            }
            steps {
                sh 'terraform plan -var-file=${TF_VAR_file}'
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                sh 'terraform apply -auto-approve -var-file=${TF_VAR_file}'
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                sh 'terraform destroy -auto-approve -var-file=${TF_VAR_file}'
            }
        }

        stage('Save Credentials and Keys') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                sh 'bash scripts/write_creds.sh'
            }
        }
    }

    post {
        failure {
            echo 'Terraform operation failed.'
        }
    }
}

