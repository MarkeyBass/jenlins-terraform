# Creating jenkins pipeline that is connected to terraform
# ==========================================================

# Adding terraform into jenkins container - Old school manually
# ℹ - Jenkins runs on Debian container ℹ

# 💲 ssh ubuntu@52.207.130.141
# 💲 sudo docker exec -u root -it JenkinsController bash
# 💲 apt update
# 💲 apt install nano
# 💲 apt install wget


# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli


# 💲 apt-get update &apt-get install -y gnupg software-properties-common

# 💲
# wget -O- https://apt.releases.hashicorp.com/gpg | \
# gpg --dearmor | \
# tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

# 💲
# gpg --no-default-keyring \
# --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
# --fingerprint

# 💲
# echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
# https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
# tee /etc/apt/sources.list.d/hashicorp.list

# 💲
# 💲 apt-get install terraform

# 💲 terraform --version


# connecting the terraform to our aws provider
# =================================================
# 💲 # exit


# Switching user to jenkins && going to home directory (~) + adding credentials and config
# ==========================================================================================
# 💲 sudo docker exec -it JenkinsController bash
# 💲 cd
# 💲 mkdir .aws/

# 💲 nano credentials
# --------------------
# [default]
# aws_access_key_id = <aws_access_key_id>
# aws_secret_access_key = <aws_secret_access_key>

# 💲 nano config
# ---------------
# [default]
# region=us-east-1
# output=json


# Another check
# ================
# jenkins@32b8a66b46ff:~$ ls -la .aws
# total 16
# drwxr-xr-x  2 jenkins jenkins 4096 May 18 16:33 .
# drwxr-xr-x 21 jenkins jenkins 4096 May 18 16:32 ..
# -rw-r--r--  1 jenkins jenkins   39 May 18 16:33 cconfig
# -rw-r--r--  1 jenkins jenkins  116 May 18 16:33 credentials

# TERRAFORM CONFIGURED!!! 🎉🎉🎉

# creating pipeline that will will get terraform code from github and exercutes it
# ===================================================================================

provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "terafform-jenkins" {
  ami           = "ami-0aa2b7722dc1b5612"
  instance_type = "t2.micro"
  tags = {
    Name = "terafform-jenkins"
  }
}  

resource "aws_s3_bucket" "terraform-bucket" {
  bucket = "terraform-bucket-1"
  acl    = "private"

  tags = {
    Name = "terraform-bucket-1"
  }
}


# Putting it to gitub
# ======================
# git remote add origin git@github.com:MarkeyBass/jenlins-terraform.git
# git branch -M main
# git push -u origin main


# Inside JenkinsController GUI
# ==============================


# pipeline {
#     agent any 
#     stages {
#         stage('Checkout') {
#             steps{
#                 git branch: "main", url: "https://github.com/MarkeyBass/jenlins-terraform.git"
#             }
#         }
#         stage('Terraform init') {
#             steps {
#                 sh 'terraform init'
#             }
#         }
#         // There is no interaction with the terminal we do directly apply
#         // we have --auto-approve so there is no need of terraform plan
#         stage('Terraform apply') {
#             steps {
#                 sh 'terraform apply --auto-approve'
#             }
#         }
#     }
# }
