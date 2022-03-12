# Terraform-App-Deployment

This Project is an automation that spins up a deployment environment in AWS, starting with provisioning a VPC and subnets with Terraform, creation of workloads in EC2  and deployment of a simple hello-world Python application.

## Preriquisites
1. Install terraform (v1.0.0 or later).
2. Install Git
3. AWS credentials to allow terraform create resources (Current Supported Way: Access and Secret Key).

## How to Use

1.Open gitbash  
2.Create a directory using command `mkdir`  
3.Clone the IAC github repository - https://github.com/azimazad/Terraform-App-Deployment.git ,Using `git clone` into the directory.  
4.Run terraform init to setup the terraform backend - `terraform init`  
5.Apply terraform passing secret and access key as variables - `terraform apply -var 'access_key=****' -var 'secret_key=****'`  
6.Replace the variable values with your own credentials.  
7.Run terraform output to grab the public ip from the app instance = `terraform output app_instance_ip`  
8.Wait about four or five minutes after terraform ends the execution. This script uses the userdata from ec2 to configure the instance, it take some time.  
9.Use the public ip in your browser to see the message from the webapp hosted inside the ec2 instance.  
10.If you want to destroy the infrastructure, simple use terraform destroy command - `terraform destroy -var 'access_key=****' -var 'secret_key=****'`  

## Terraform Defaults

- vpc_cidr_block     - 10.0.0.0/16
- public_cidr_block  - 10.0.1.0/24
- private_cidr_block - 10.0.2.0/24
- instance_type      - t2.micro
- image_id           - Amazon Linux 2
- Terraform Backend  - local folder
- region             - us-east-1

## Terraform Backend

By default, the backend is stored inside local folder.
