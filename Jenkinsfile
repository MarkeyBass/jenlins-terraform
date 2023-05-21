pipeline {
    agent any 

    parameters {
        string(name: 'bucket_url', defaultValue: 's3://terraform-jenkins-bucket-pub')
        // params.graph_file && params.graph_img defined in the jenkins console
    }

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
        // creating enviroment graph and dropping it into the bucket
        stage('Graph creation') {
            steps {
                // sh 'terraform graph > graph.dot'
                sh "terraform graph > ${params.graph_file}"
                sh "dot -Tpng graph.dot -o  ${params.graph_img}"
            }
        }
        stage('Uploading graph to s3 bucket') {
            steps {
                sh "aws s3 cp ./${params.graph_img} ${params.bucket_url}"
            }
        }
    }
}
