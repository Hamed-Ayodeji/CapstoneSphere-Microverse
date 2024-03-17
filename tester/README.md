# Tester

## Overview

The Tester directory consists of a Terraform configuration file (`tester.tf`) and a Bash script (`tester.sh`). These files are designed to work in tandem to deploy and provision a test environment on Amazon Web Services (AWS).

### tester.tf

The `tester.tf` file outlines the Terraform configuration for deploying an AWS EC2 instance of type `t2.2xlarge`. This instance is provisioned within a custom Virtual Private Cloud (VPC), equipped with necessary resources such as a dedicated security group.

**Note:** This script assumes that you have the AWS CLI installed and configured with the necessary credentials. The default profile is used for the AWS CLI configuration. If you have a different profile name, you will need to modify the script accordingly.

### tester.sh

The `tester.sh` script is a provisioning tool that runs on the EC2 instance post-deployment. This script sets up the software environment within the instance.

## Usage

To deploy the test environment, ensure Terraform is installed on your local machine. Follow these steps:

    1. Navigate to the Tester directory:

    ```bash
    cd tester
    ```

    2. Initialize your Terraform workspace, which will download the provider plugins:

    ```bash
    terraform init
    ```

    3. Generate and show an execution plan:

    ```bash
    terraform plan
    ```

    4. Deploy the test environment to AWS:

    ```bash
    terraform apply -auto-approve
    ```

    This will deploy the EC2 instance and its associated resources on AWS and execute the tester.sh script to provision the instance. All you need to do is go to the AWS Management Console and connect to the instance using SSH.

    You can now clone your repository and run the tests on the EC2 instance.

## Cleanup

To remove the test environment from AWS, navigate to the Tester directory and run the following command:

    ```bash
    cd tester
    terraform destroy -auto-approve
    ```

This command will remove all resources associated with the test environment from AWS.

## Conclusion

This is created for the sole purpose of testing all the various components of the capstone project, before building the pipeline. In order to prevent difficulties in debugging the pipeline, it is important to ensure that all the components are working as expected. This is the purpose of the tester directory.
