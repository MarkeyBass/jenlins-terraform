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


# Putting it to gitub