pipeline {
    agent any 
    stages {
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        // There is no interaction with the terminal we do directly apply
        // we have --auto-approve so there is no need of terraform plan
        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
    }
}
