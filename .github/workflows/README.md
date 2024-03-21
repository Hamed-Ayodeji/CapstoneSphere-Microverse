# Deploy Sockshop on Azure Kubernetes Service (AKS) Workflow

This GitHub Actions workflow file automates the deployment of Sockshop, a microservices-based demo application, onto Azure Kubernetes Service (AKS). The workflow allows for both building and cleaning up the deployment environment based on user input.

## Overview of GitHub Actions

GitHub Actions is a feature of GitHub that enables continuous integration (CI) and continuous deployment (CD) workflows directly within your GitHub repository. With GitHub Actions, you can automate tasks, build, test, and deploy your code directly from GitHub.

## Workflow Details

### Workflow Trigger

This workflow is triggered manually using the `workflow_dispatch` event, allowing users to choose between two actions: `build` and `cleanup`. The `build` action deploys the Sockshop application, while the `cleanup` action removes the deployed resources.

### Permissions

The workflow requires specific permissions to interact with the repository's contents and obtain an identity token for necessary operations.

### Jobs

The workflow consists of two main jobs:

1. **Deploy Job**: This job runs on an Ubuntu environment (`ubuntu-latest`) and executes the deployment steps when triggered with the `build` action.

2. **Cleanup Job**: This job runs when triggered with the `cleanup` action and destroys the deployed infrastructure to clean up resources.

### Steps

#### Deploy Job Steps

1. **Checkout Code**: Checks out the repository's code using the `actions/checkout@v2` action.

2. **Install Azure CLI**: Installs the Azure CLI if the action is set to `build`.

3. **Install Necessary Tools**: Installs necessary tools like `curl`, `unzip`, `wget`, etc., required for deployment.

4. **Install Terraform**: Installs Terraform for managing infrastructure as code.

5. **Install kubectl**: Installs `kubectl` to interact with Kubernetes clusters.

6. **Install Helm**: Installs Helm, a package manager for Kubernetes.

7. **Azure Login**: Logs in to Azure using the Azure CLI.

8. **Terraform Setup and Apply/Destroy (Infrastructure)**: Initializes and applies Terraform configurations for infrastructure provisioning or destruction.

9. **Wait for Kubernetes Cluster to be Ready**: Adds a delay to ensure the Kubernetes cluster is ready before proceeding.

10. **Get AKS Credentials**: Retrieves AKS credentials to interact with the Kubernetes cluster.

11. **Terraform Setup and Apply/Destroy (Helm Charts)**: Initializes and applies Terraform configurations for deploying Helm charts.

12. **Apply Microservices YAML**: Applies YAML files for deploying microservices.

13. **Apply Let's Encrypt YAML**: Applies YAML files for Let's Encrypt.

14. **Apply NGINX Ingress YAML**: Applies NGINX Ingress controller YAML.

15. **Wait for NGINX Ingress to be Ready**: Adds a delay to ensure NGINX Ingress is ready before proceeding.

16. **Apply Sock-shop YAML in Ingress Directory**: Applies YAML files for deploying Sockshop.

17. **Apply Prometheus Stack YAMLs**: Applies YAML files for deploying Prometheus stack components.

18. **Apply Grafana YAML**: Applies YAML files for deploying Grafana.

19. **Apply Alert Manager YAML**: Applies YAML files for deploying Alert Manager.

20. **Apply ELK Stack YAMLs**: Applies YAML files for deploying ELK Stack components.

#### Cleanup Job Steps

1. **Clean Up**: Destroys infrastructure using Terraform if triggered with the `cleanup` action.

## Applying Configuration

To apply this workflow configuration:

1. Copy the provided YAML code and save it as `deploy.yml` in your GitHub repository's `.github/workflows` directory.

2. Make sure you have the necessary permissions to perform the actions defined in the workflow.

3. Trigger the workflow manually by navigating to the Actions tab in your GitHub repository, selecting the workflow, and choosing the desired action (build or cleanup) from the dropdown menu.

4. Monitor the workflow execution for any errors or failures.

By following these steps, you can effectively deploy and manage the Sockshop application on Azure Kubernetes Service using GitHub Actions.