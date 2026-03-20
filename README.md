# 💰 WalletAnalyser Azure Infrastructure

This repository contains the Terraform configuration for the Azure infrastructure of the **WalletAnalyser** project.

WalletAnalyser is a portfolio analysis platform that allows users to import their investment portfolios, analyze their performance, visualize asset allocation, and compare them with benchmarks.

The infrastructure deployed by this repository supports:

- 📥 Portfolio import (CSV / Excel)
- 🗂 Portfolio data management
- 📊 Financial analytics and performance metrics
- 📈 Portfolio comparison with benchmarks
- 🌍 Visualization APIs used by web and mobile applications

This infrastructure provides the backend services, cloud resources, and data storage required for the WalletAnalyser platform.

---

# ☁️ Infrastructure

This Terraform configuration will eventually deploy the following Azure resources:

- 🧱 A Resource Group
- 🌐 Two App Services (Frontend API / Backend Analytics API)
- 🐘 A PostgreSQL database
- 🗃 Blob Storage (for CSV / Excel portfolio imports)
- 🔐 A Key Vault (for secrets management)
- 📡 Application Insights (monitoring and telemetry)

These services support portfolio ingestion, financial analytics, and secure storage of user data.

---

# ⚙️ Local Setup (Optional)

Local execution is optional because infrastructure deployment should normally be handled by **CI/CD pipelines**.

---

## 1️⃣ Create a `.env` file using `.env.example`

```.env
ARM_CLIENT_ID=xxxx
ARM_CLIENT_SECRET=xxxx
ARM_TENANT_ID=xxxx
ARM_SUBSCRIPTION_ID=xxxx
```

These credentials allow Terraform to authenticate with Azure.

---

## 2️⃣ Initialize Terraform

Navigate to the infrastructure directory and initialize Terraform.

```shell
cd infrastructure
terraform init
```

This command initializes the Terraform backend and downloads required providers.

---

## 3️⃣ (Optional) Run Terraform locally

In most situations the infrastructure will be deployed automatically via CI/CD.  
However, local deployment can still be performed if necessary.

```shell
terraform apply -auto-approve
```

> [!IMPORTANT]
> Local Terraform executions should only be performed in exceptional cases. CI/CD should remain the primary deployment mechanism.

---

# 🧾 Terraform Variables

Terraform requires environment-specific variables that must be provided locally.

Create a `terraform.tfvars` file inside the **infrastructure/** directory.

```shell
cd infrastructure
cp terraform.tfvars.example terraform.tfvars
```

Example configuration:

```.tfvars
cors_frontend_addresses = [] # Frontend addresses allowed to communicate with the backend API

postgresql_admin_username = "" # PostgreSQL admin username
postgresql_admin_password = "" # PostgreSQL admin password

allowed_ips = [] # IP addresses allowed to connect to the PostgreSQL server
aim_users_rg = [] # All guests emails in the tenant

storage_account_name = "" # Azure storage account name
portfolio_blob_container = "" # Blob container storing portfolio imports
```

After copying the template, update the values so they match the WalletAnalyser infrastructure requirements.

> [!CAUTION]
> The `terraform.tfvars` file **must not be committed** to the repository. It must remain local and contain sensitive values.

---

# 🚀 CI/CD

A **GitHub Actions workflow** is included in the repository.

When code is pushed to the **main branch**, the pipeline will automatically:

- Initialize Terraform
- Validate the configuration
- Apply infrastructure changes to Azure

Sensitive variables are injected using **GitHub Secrets** following Terraform conventions.

```yml
TF_VAR_<variable_name>
```

Example:

```yml
TF_VAR_postgresql_admin_password
```

This ensures secrets are securely managed without being stored in the repository.

---

# 🔐 Security Notes

Please follow these rules:

- ❌ Do **not commit** your `.env` file
- ❌ Do **not commit** `terraform.tfvars`
- 🔑 Store sensitive values in **GitHub Secrets**
- 🔒 Use **Azure Key Vault** for production secrets

---

# 📝 Notes

- Infrastructure is managed using **Terraform**
- Deployment is automated via **GitHub Actions**
- Local Terraform runs are optional and should remain rare
- This repository contains **only the infrastructure** required for WalletAnalyser
