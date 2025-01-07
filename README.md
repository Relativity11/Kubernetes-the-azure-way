# Terraform Kubernetes Setup

This project contains Terraform scripts to set up a Kubernetes cluster in Azure, following the "Kubernetes the Hard Way" approach. It creates a resource group, a virtual network, a subnet, and four virtual machines: a jumpbox for administration and three nodes for the Kubernetes cluster.

## Project Structure

- `main.tf`: Contains the main configuration for Terraform, defining the resource group, virtual network, and virtual machines.
- `variables.tf`: Defines input variables for the Terraform configuration, including resource names and sizes.
- `outputs.tf`: Specifies the outputs of the Terraform configuration, such as public IP addresses and resource group name.
- `README.md`: Documentation for the project, including setup instructions.

## Prerequisites

- An Azure account with sufficient permissions to create resources.
- Terraform installed on your local machine.

## Getting Started

1. Clone the repository:
   ```sh
   git clone <repository-url>
   cd terraform-k8s-setup
   ```

2. Create a `terraform.tfvars` file with your Azure Subscription ID, admin username, and admin password:
   ```sh
   subscription_id = "your-subscription-id"
   admin_username  = "your-admin-username"
   admin_password  = "your-admin-password"
   ```

3. Initialize Terraform:
   ```sh
   terraform init
   ```

4. Apply the Terraform configuration:
   ```sh
   terraform apply
   ```

## What This Project Creates

- **Resource Group**: A new resource group to contain all the resources.
- **Virtual Network and Subnet**: A virtual network with a subnet for the VMs.
- **Virtual Machines**: Four virtual machines with 4 vCPUs and 8-16GB of RAM each:
  - **Jumpbox**: Used for administration and running commands.
  - **Three Nodes**: Used for the Kubernetes cluster.

This setup prepares you to begin "Kubernetes the Hard Way" with `amd64` architecture using Azure Commercial resources.

## Disclaimer

These are large VMs that will incur costs. Please ensure you understand the pricing and have the necessary budget before proceeding.

## Additional Uses

Beyond Kubernetes the Hard Way, these VMs can also be used to install tools like Rancher Manager, Elastic, and other applications.

Continue with Kubernetes The Hard Way here: [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/03-compute-resources.md)