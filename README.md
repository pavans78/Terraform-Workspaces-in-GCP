# Terraform-Workspaces-in-GCP

Terraform Workspaces provide a mechanism to manage multiple environments (e.g., development, staging, production) using the same set of configuration files. This allows you to easily switch between different states without modifying the infrastructure code. Here are some key points about Terraform Workspaces:

### What are Terraform Workspaces?

1. **Default Workspace**: When you first start using Terraform, you're in the default workspace named "default".

2. **Named Workspaces**: In addition to the default workspace, you can create additional named workspaces.

### Commands for Workspaces

- **Create a New Workspace**: 
  ```sh
  terraform workspace new <workspace_name>
  ```
- **List All Workspaces**:
  ```sh
  terraform workspace list
  ```
- **Select a Workspace**:
  ```sh
  terraform workspace select <workspace_name>
  ```
- **Show the Current Workspace**:
  ```sh
  terraform workspace show
  ```
- **Delete a Workspace**:
  ```sh
  terraform workspace delete <workspace_name>
  ```

### Scenario :

In this repo, I am using the same configuration and same GCS bucket for backends. I created the GCS bucket using the terraform.

1. Initialize the new Terraform configuration by running the terraform init command in the same directory as the main.tf file:

    ```
       terraform init
    ```

1. List the Workspaces in current working directory:
  
    ```
       terraform workspace list
       * default
    ```
2. Create the workspaces(dev, test, prod) in the current working directory: 

    ```sh
       terraform workspace new dev
       terraform workspace new test
       terraform workspace new prod
    ```

3. List the Workspaces in current working directory :
  
    ```sh
        terraform workspace list
        * default
        dev
        test
        prod
    ```

4. Select a Workspace as `dev` and it changed the workspace from default to dev workspace:
  
    ```sh
       terraform workspace select dev
    ```


5. format the files and See the execution plan by running the terraform plan command with var-file, var-file is the inputs of the variables:

    ```sh
       terraform fmt -check
       terraform plan -var-file=_dev.tfvars -out=plan.tfplan
    ```

6. Apply you configuration now by running the command terraform apply, it was created the GCS bucket in the GCP Project:

    ```sh
       terraform apply plans.tfplan
    ```

After successfully terraform apply command, it was updated the state file in the gcs bucket backend under the folder `gcs-bucket-79` and created the state file as`dev.tfstate`.

repeated the step 4 to step 6 for the `test` and `prod` workspaces, only in the step 5 I changed the var-file=_test.tfvars and _prod.tfvars for the respective workspaces. 

After successfully terraform apply command for the both test and prod, it was created the different GCS bucket in the GCP Project based on the `.tfvars` file in both workspaces and it was updated the state file in the gcs bucket backend under the folder `gcs-bucket-79` and created the state files as `test.tfstate` and `prod.tfstate` for the respective workspace.

Here is the list of the state files under the folder `gcs-bucket-79` created by the different workspaces:

![image](https://github.com/pavans78/Terraform-Workspaces-in-GCP/assets/75356244/bcbbbf16-e359-4a0b-8a39-3ece450aed9e)


### How Workspaces Work

- **State Management**: Each workspace has its own state file, which means changes in one workspace do not affect the state of another workspace.

- **Isolation**: Workspaces are isolated from each other; resources managed in one workspace are distinct from those in another.

### Use Cases for Workspaces

1. **Environment Management**: Separate environments like dev, staging, and prod.
2. **Feature Branches**: Isolate infrastructure changes in feature branches before merging.
3. **Multiple Deployments**: Manage multiple deployments with a single set of configuration files.

### Best Practices

- **Naming Conventions**: Use clear and consistent naming conventions for your workspaces.
- **Workspace-Specific Variables**: Use different variable values for different workspaces by using Terraform's `terraform.workspace` interpolation to conditionally set values.
- **Resource Management**: Be cautious about resource names and identifiers to avoid conflicts between workspaces.

### Conclusion

Terraform workspaces are a powerful tool for managing multiple environments within a single project. By isolating state files and maintaining consistent configurations across environments, workspaces help ensure infrastructure stability and reduce the risk of errors during deployment. Proper usage of workspaces, combined with best practices, can greatly enhance the efficiency and reliability of your infrastructure management processes.

