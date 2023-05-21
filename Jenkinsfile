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
                sh "aws s3 cp ./${params.graph_img} s3://terraform-jenkins-bucket-pub"
            }
        }
        // creating enviroment graph and dropping it into the bucket
        // stage('Uploading graph to s3 bucket') {
        //     steps {
        //         script {
        //             def timestamp
        //             if (fileExists('graph.png')) {
                                             
                        
        //                 withAWS(credentials: 'awscredentials', region: 'us-east-1') {
        //                     s3Upload(
        //                         file: "graph.png",
        //                         bucket: "${AWS_BUCKET}",
        //                         path: "graph.png"
        //                     )
        //                 }                        
        //             } else {
        //                 error('No graph.png found')
        //             }
        //         }
        //     }
        // }
    }
}
