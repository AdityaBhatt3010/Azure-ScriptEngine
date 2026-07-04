# Azure Script Engine

An interactive Azure administration toolkit built using **Bash** and **PowerShell** that simplifies common Microsoft Azure management tasks through menu-driven command-line interfaces.

Azure Script Engine provides an easy-to-use collection of scripts for performing routine Azure administration without remembering lengthy Azure CLI commands. It is designed for students, cloud engineers, system administrators, and anyone learning Azure infrastructure.

Every module is available for both **Linux (Bash)** and **Windows (PowerShell)** while maintaining a consistent user experience across platforms.

---

# Features

- Interactive menu-driven interface
- Cross-platform support
  - Linux (Bash)
  - Windows (PowerShell)
- Uses Microsoft Azure CLI
- Beginner friendly
- No additional dependencies
- Modular project structure
- Easy to extend
- Well-commented scripts
- Lightweight
- Open Source

---

# Supported Azure Services

| Service | Linux | Windows |
|----------|:-----:|:-------:|
| Azure CLI Setup | ✅ | ✅ |
| Resource Groups | ✅ | ✅ |
| Virtual Machines | ✅ | ✅ |
| Storage Accounts | ✅ | ✅ |
| Virtual Networks | ✅ | ✅ |
| Network Security Groups | ✅ | ✅ |
| Azure Key Vault | ✅ | ✅ |

---

# Repository Structure

```text
Azure-ScriptEngine/

│
├── Azure_CLI_Setup_Linux.sh
├── Azure_CLI_Setup_Windows.ps1
│
├── Azure_VM_Linux.sh
├── Azure_VM_Windows.ps1
│
├── Azure_Storage_Linux.sh
├── Azure_Storage_Windows.ps1
│
├── Azure_ResourceGroup_Linux.sh
├── Azure_ResourceGroup_Windows.ps1
│
├── Azure_VNet_Linux.sh
├── Azure_VNet_Windows.ps1
│
├── Azure_NSG_Linux.sh
├── Azure_NSG_Windows.ps1
│
├── Azure_KeyVault_Linux.sh
├── Azure_KeyVault_Windows.ps1
│
├── README.md
└── LICENSE
```

---

# Project Architecture

```text
                     Azure Script Engine

                             │
        ┌────────────────────┴────────────────────┐
        │                                         │
     Linux (.sh)                          Windows (.ps1)

        │                                         │
        ├── Azure CLI Setup               Azure CLI Setup
        ├── Resource Groups               Resource Groups
        ├── Virtual Machines              Virtual Machines
        ├── Storage Accounts              Storage Accounts
        ├── Virtual Networks              Virtual Networks
        ├── Network Security Groups       Network Security Groups
        └── Azure Key Vault               Azure Key Vault
```

---

# Prerequisites

Before running the scripts, ensure the following software is installed.

## Linux

- Bash
- curl
- Azure CLI
- Internet Connection
- Azure Subscription

## Windows

- PowerShell 5.1 or later
- Winget (recommended)
- Azure CLI
- Internet Connection
- Azure Subscription

---

# Azure CLI Installation

## Linux

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

Verify installation

```bash
az version
```

Login

```bash
az login
```

---

## Windows

Install Azure CLI

```powershell
winget install Microsoft.AzureCLI
```

Verify installation

```powershell
az version
```

Login

```powershell
az login
```

---

# Running the Scripts

## Linux

Grant execution permission.

```bash
chmod +x Azure_VM_Linux.sh
```

Run the script.

```bash
./Azure_VM_Linux.sh
```

---

## Windows

Open PowerShell.

Navigate to the project directory.

Execute the script.

```powershell
.\Azure_VM_Windows.ps1
```

If PowerShell execution is disabled, run:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

# Design Goals

Azure Script Engine was developed with the following objectives.

- Simplicity
- Readability
- Cross-platform compatibility
- Interactive menus
- Beginner-friendly interface
- Azure CLI automation
- Modular code structure
- Easy maintenance
- Easy future expansion

---

# Module Documentation

Each script included in Azure Script Engine is designed around an interactive menu-driven interface. Every operation internally executes the appropriate Azure CLI commands while providing a simple and consistent user experience.

Each module is available for both Linux (Bash) and Windows (PowerShell).

---

# Module 1 : Azure CLI Setup

Files

```text
Azure_CLI_Setup_Linux.sh
Azure_CLI_Setup_Windows.ps1
```

Purpose

Configure Azure CLI and manage Azure account authentication.

This module serves as the starting point before using any other script within Azure Script Engine.

---

## Features

- Install Azure CLI
- Login to Azure
- Logout
- Show Current Account
- List Available Subscriptions
- Switch Subscription
- Display Azure CLI Version

---

## Menu

```text
==================================================
 Azure CLI Setup & Account Management
==================================================

1. Install Azure CLI
2. Login to Azure
3. Show Current Account
4. List Subscriptions
5. Switch Subscription
6. Check Azure CLI Version
7. Logout
8. Exit
```

---

## Azure CLI Commands Used

```text
az login

az logout

az version

az account show

az account list

az account set
```

---

## Typical Workflow

```text
Install Azure CLI

↓

Login

↓

Verify Account

↓

Select Subscription

↓

Use Remaining Modules
```

---

# Module 2 : Resource Groups

Files

```text
Azure_ResourceGroup_Linux.sh

Azure_ResourceGroup_Windows.ps1
```

Purpose

Manage Azure Resource Groups using Azure CLI.

Every Azure resource belongs to a Resource Group. This module simplifies creating, viewing, and managing Resource Groups.

---

## Features

- Create Resource Group
- List Resource Groups
- Show Resource Group Details
- Delete Resource Group
- Deployment History
- List Azure Regions
- Check Resource Group Exists

---

## Menu

```text
==================================================
 Azure Resource Group Management
==================================================

1. Create Resource Group

2. List Resource Groups

3. Show Resource Group Details

4. Delete Resource Group

5. Deployment History

6. List Azure Locations

7. Check Resource Group Exists

8. Exit
```

---

## Azure CLI Commands Used

```text
az group create

az group list

az group show

az group delete

az deployment group list

az account list-locations

az group exists
```

---

## Typical Workflow

```text
Create Resource Group

↓

Verify Resource Group

↓

Deploy Resources

↓

Review Deployment History
```

---

## Example

```text
Resource Group : DemoRG

Location : Central India

↓

Creates

DemoRG
```

---

# Cross Platform Compatibility

Both Linux and Windows versions provide identical functionality.

| Feature | Linux | Windows |
|----------|:------:|:--------:|
| Interactive Menu | ✅ | ✅ |
| Azure CLI | ✅ | ✅ |
| Login Verification | ✅ | ✅ |
| Input Validation | ✅ | ✅ |
| Confirmation Prompts | ✅ | ✅ |

---

# Error Handling

Azure Script Engine performs several validation checks before executing Azure CLI commands.

Examples include:

- Azure CLI installed
- User logged in
- Empty input validation
- Invalid menu option detection
- Confirmation before delete operations

These checks help reduce common user errors while using Azure CLI.

---

# Module 3 : Virtual Machines

Files

```text
Azure_VM_Linux.sh

Azure_VM_Windows.ps1
```

Purpose

Deploy and manage Azure Virtual Machines using Azure CLI through an interactive menu-driven interface.

This module covers the complete Virtual Machine lifecycle, including provisioning, power management, information retrieval, and deletion.

---

## Features

- Create Virtual Machine
- List Virtual Machines
- Start Virtual Machine
- Stop Virtual Machine
- Restart Virtual Machine
- Deallocate Virtual Machine
- Show Virtual Machine Details
- Delete Virtual Machine
- List Available VM Sizes

---

## Menu

```text
==================================================
 Azure Virtual Machine Management
==================================================

1. Create Virtual Machine
2. List Virtual Machines
3. Start Virtual Machine
4. Stop Virtual Machine
5. Restart Virtual Machine
6. Deallocate Virtual Machine
7. Show Virtual Machine Details
8. Delete Virtual Machine
9. List Available VM Sizes
10. Exit
```

---

## Azure CLI Commands Used

```text
az vm create

az vm list

az vm show

az vm start

az vm stop

az vm restart

az vm deallocate

az vm delete

az vm list-sizes
```

---

## VM Creation Workflow

```text
Select Resource Group

↓

Enter Virtual Machine Name

↓

Choose Operating System

↓

Select Virtual Machine Size

↓

Enter Administrator Username

↓

Choose Authentication Method

↓

Create Virtual Machine
```

---

## Operating Systems Supported

Linux

- Ubuntu 24.04 LTS
- Ubuntu 22.04 LTS

Windows

- Windows Server 2022 Datacenter

---

## Authentication Options

Linux

- SSH Key
- Password

Windows

- Password Authentication

---

## Example

```text
Resource Group : DemoRG

Virtual Machine : DemoVM

Image : Ubuntu 24.04

Size : Standard_B2s

↓

Virtual Machine Created Successfully
```

---

# Module 4 : Azure Storage

Files

```text
Azure_Storage_Linux.sh

Azure_Storage_Windows.ps1
```

Purpose

Manage Azure Storage Accounts and Blob Storage resources using Azure CLI.

The module provides a simple interface for creating Storage Accounts, managing Blob Containers, and transferring files.

---

## Features

- Create Storage Account
- List Storage Accounts
- Show Storage Account Details
- Delete Storage Account
- Create Blob Container
- List Blob Containers
- Upload Blob
- Download Blob
- Delete Blob

---

## Menu

```text
==================================================
 Azure Storage Management
==================================================

1. Create Storage Account
2. List Storage Accounts
3. Show Storage Account Details
4. Delete Storage Account
5. Create Blob Container
6. List Blob Containers
7. Upload Blob
8. Download Blob
9. Delete Blob
10. Exit
```

---

## Azure CLI Commands Used

```text
az storage account create

az storage account list

az storage account show

az storage account delete

az storage container create

az storage container list

az storage blob upload

az storage blob download

az storage blob delete
```

---

## Storage Workflow

```text
Create Storage Account

↓

Create Blob Container

↓

Upload Files

↓

Download Files

↓

Delete Files
```

---

## Blob Operations

Azure Script Engine supports the following Blob Storage operations.

- Upload local files
- Download blobs
- Delete blobs
- List containers

---

## Example

```text
Storage Account : mystorage001

Container : project-files

↓

Upload Blob

↓

File Successfully Uploaded
```

---

# Compute & Storage Summary

| Module | Operations |
|---------|------------|
| Virtual Machines | Provisioning, Power Management, Monitoring, Deletion |
| Storage | Storage Accounts, Containers, Blob Upload, Blob Download, Blob Deletion |

---

# Cross Platform Support

Both Linux and Windows implementations provide identical functionality and menu structure.

| Feature | Linux | Windows |
|----------|:------:|:--------:|
| Interactive Menu | ✅ | ✅ |
| Azure CLI | ✅ | ✅ |
| Input Validation | ✅ | ✅ |
| Confirmation Prompts | ✅ | ✅ |
| Authentication Checks | ✅ | ✅ |

---

# Module 5 : Azure Virtual Network

Files

```text
Azure_VNet_Linux.sh

Azure_VNet_Windows.ps1
```

Purpose

Create and manage Azure Virtual Networks and their associated subnets using Azure CLI.

Virtual Networks provide secure network isolation for Azure resources and form the foundation for cloud networking deployments.

This module also includes Virtual Network Peering to enable communication between separate Azure Virtual Networks.

---

## Features

- Create Virtual Network
- List Virtual Networks
- Show Virtual Network
- Delete Virtual Network
- Create Subnet
- List Subnets
- Show Subnet
- Delete Subnet
- Create VNet Peering
- List VNet Peerings

---

## Menu

```text
==================================================
 Azure Virtual Network Management
==================================================

1. Create Virtual Network
2. List Virtual Networks
3. Show Virtual Network
4. Delete Virtual Network
5. Create Subnet
6. List Subnets
7. Show Subnet
8. Delete Subnet
9. Create VNet Peering
10. List VNet Peerings
11. Exit
```

---

## Azure CLI Commands Used

```text
az network vnet create

az network vnet list

az network vnet show

az network vnet delete

az network vnet subnet create

az network vnet subnet list

az network vnet subnet show

az network vnet subnet delete

az network vnet peering create

az network vnet peering list
```

---

## Typical Workflow

```text
Create Virtual Network

↓

Create Subnet

↓

Deploy Resources

↓

Configure VNet Peering

↓

Verify Connectivity
```

---

## Example

```text
Virtual Network

Name : ProductionVNet

Address Space : 10.0.0.0/16

↓

Subnet

Name : WebSubnet

Address Prefix : 10.0.1.0/24
```

---

## VNet Peering

Azure Script Engine supports creating one-way Virtual Network Peerings using Azure CLI.

Example

```text
Source VNet

↓

Remote VNet Resource ID

↓

Peering Created
```

This allows communication between two Azure Virtual Networks while maintaining separate network boundaries.

---

# Module 6 : Azure Network Security Groups

Files

```text
Azure_NSG_Linux.sh

Azure_NSG_Windows.ps1
```

Purpose

Manage Azure Network Security Groups (NSGs) and Security Rules.

Network Security Groups provide network-level traffic filtering for Azure Virtual Machines, Network Interfaces, and Subnets.

---

## Features

- Create Network Security Group
- List Network Security Groups
- Show Network Security Group
- Delete Network Security Group
- Create Security Rule
- List Security Rules
- Delete Security Rule
- Associate NSG to Subnet
- Associate NSG to Network Interface
- Remove NSG Association

---

## Menu

```text
==================================================
 Azure Network Security Group Management
==================================================

1. Create NSG
2. List NSGs
3. Show NSG
4. Delete NSG
5. Create Security Rule
6. List Security Rules
7. Delete Security Rule
8. Associate NSG to Subnet
9. Associate NSG to NIC
10. Remove NSG Association
11. Exit
```

---

## Azure CLI Commands Used

```text
az network nsg create

az network nsg list

az network nsg show

az network nsg delete

az network nsg rule create

az network nsg rule list

az network nsg rule delete

az network vnet subnet update

az network nic update
```

---

## Security Rule Parameters

Each Security Rule supports:

- Rule Name
- Priority
- Direction
- Access
- Protocol
- Destination Port

---

## Supported Directions

```text
Inbound

Outbound
```

---

## Supported Actions

```text
Allow

Deny
```

---

## Supported Protocols

```text
TCP

UDP

*
```

---

## Typical Workflow

```text
Create NSG

↓

Create Security Rule

↓

Associate NSG

↓

Apply to

• Subnet

or

• Network Interface

↓

Traffic Filtering Enabled
```

---

## Example

```text
NSG

Web-NSG

↓

Inbound Rule

Allow HTTPS

↓

Destination Port

443

↓

Associated with WebSubnet
```

---

# Networking Summary

| Module | Primary Purpose |
|---------|-----------------|
| Virtual Network | Virtual Networks, Subnets, VNet Peering |
| Network Security Groups | Traffic Filtering, Security Rules, Network Protection |

---

# Networking Architecture

```text
Internet

        │

        ▼

Network Security Group

        │

        ▼

Virtual Network

        │

        ▼

Subnet

        │

        ▼

Virtual Machine
```

---

# Cross Platform Compatibility

| Feature | Linux | Windows |
|----------|:------:|:--------:|
| Interactive Menu | ✅ | ✅ |
| Azure CLI | ✅ | ✅ |
| VNet Management | ✅ | ✅ |
| Subnet Management | ✅ | ✅ |
| NSG Management | ✅ | ✅ |
| Security Rules | ✅ | ✅ |
| Association Management | ✅ | ✅ |

---

# Module 7 : Azure Key Vault

Files

```text
Azure_KeyVault_Linux.sh

Azure_KeyVault_Windows.ps1
```

Purpose

Manage Azure Key Vault resources using Azure CLI.

Azure Key Vault provides secure storage and management for application secrets, cryptographic keys, and certificates.

This module simplifies common Key Vault administration tasks through an interactive menu-driven interface.

---

## Features

- Create Key Vault
- List Key Vaults
- Show Key Vault
- Delete Key Vault
- Create Secret
- List Secrets
- Show Secret
- Delete Secret
- List Keys
- List Certificates

---

## Menu

```text
==================================================
 Azure Key Vault Management
==================================================

1. Create Key Vault
2. List Key Vaults
3. Show Key Vault
4. Delete Key Vault
5. Create Secret
6. List Secrets
7. Show Secret
8. Delete Secret
9. List Keys
10. List Certificates
11. Exit
```

---

## Azure CLI Commands Used

```text
az keyvault create

az keyvault list

az keyvault show

az keyvault delete

az keyvault secret set

az keyvault secret list

az keyvault secret show

az keyvault secret delete

az keyvault key list

az keyvault certificate list
```

---

## Typical Workflow

```text
Create Key Vault

↓

Store Secret

↓

Retrieve Secret

↓

Manage Keys

↓

Manage Certificates
```

---

## Example

```text
Key Vault

CompanyVault

↓

Secret

DatabasePassword

↓

Stored Successfully
```

---

# Azure Services Covered

| Azure Service | Linux | Windows |
|---------------|:------:|:--------:|
| Azure CLI Setup | ✅ | ✅ |
| Resource Groups | ✅ | ✅ |
| Virtual Machines | ✅ | ✅ |
| Storage Accounts | ✅ | ✅ |
| Blob Containers | ✅ | ✅ |
| Blob Operations | ✅ | ✅ |
| Virtual Networks | ✅ | ✅ |
| Subnets | ✅ | ✅ |
| VNet Peering | ✅ | ✅ |
| Network Security Groups | ✅ | ✅ |
| NSG Rules | ✅ | ✅ |
| NSG Associations | ✅ | ✅ |
| Key Vault | ✅ | ✅ |
| Secrets | ✅ | ✅ |
| Keys | ✅ | ✅ |
| Certificates | ✅ | ✅ |

---

# Script Summary

| Script | Purpose |
|---------|---------|
| Azure_CLI_Setup | Azure CLI installation and account management |
| Azure_ResourceGroup | Azure Resource Group management |
| Azure_VM | Azure Virtual Machine lifecycle management |
| Azure_Storage | Storage Account and Blob management |
| Azure_VNet | Virtual Network and Subnet management |
| Azure_NSG | Network Security Group management |
| Azure_KeyVault | Secret, Key and Certificate management |

---

# Project Statistics

| Category | Value |
|----------|------:|
| Total Scripts | 14 |
| Bash Scripts | 7 |
| PowerShell Scripts | 7 |
| Azure Services Covered | 7 |
| Interactive Menus | 14 |
| Platforms Supported | 2 |
| Azure CLI Commands Used | 50+ |

---

# Common Use Cases

Azure Script Engine can be used for:

- Azure administration practice
- Azure CLI learning
- AZ-900 laboratory exercises
- AZ-104 administration practice
- Cloud engineering demonstrations
- Classroom demonstrations
- Self-learning
- Automation reference
- Command reference
- Infrastructure management

---

# Best Practices

Before running the scripts:

- Install the latest Azure CLI.
- Verify Azure CLI installation.
- Authenticate using `az login`.
- Select the correct Azure subscription.
- Use descriptive resource names.
- Verify Azure regions before deployment.
- Review resources before deletion.
- Store secrets only in Azure Key Vault.
- Follow the principle of least privilege.
- Remove unused Azure resources to avoid unnecessary costs.

---

# Error Handling

Each script performs several validation checks before executing Azure CLI commands.

Implemented validations include:

- Azure CLI installation check
- Azure authentication check
- Empty input validation
- Invalid menu option detection
- Delete confirmation prompts

These checks help reduce accidental operations and improve usability.

---

# Current Project Scope

Azure Script Engine currently focuses on Azure infrastructure management using Azure CLI.

The project covers:

- Compute
- Storage
- Networking
- Security
- Resource Management

Additional Azure services are planned for future releases.

---

# Contributing

Contributions, suggestions, improvements, and bug reports are welcome.

If you would like to contribute:

1. Fork the repository.
2. Create a feature branch.
3. Commit your changes.
4. Push the branch.
5. Open a Pull Request.

Please ensure new features follow the existing project structure and coding style.

---

# License

This project is licensed under the MIT License.

See the `LICENSE` file included in this repository for the complete license text.

---

# Version

```text
Azure Script Engine

Version 1.0
```

---

# Repository Highlights

- Cross-platform support
- Bash and PowerShell implementations
- Azure CLI based automation
- Interactive menu-driven interface
- Modular project structure
- Well documented
- Beginner friendly
- Open Source

---

# Learning Objectives

Azure Script Engine was developed to help users:

- Learn Azure CLI
- Practice Azure administration
- Understand Azure infrastructure
- Automate repetitive cloud operations
- Explore Azure services through practical examples
- Build familiarity with Bash and PowerShell scripting

---

# Acknowledgements

This project utilizes the Microsoft Azure CLI to automate Azure resource management across multiple Azure services.

Special thanks to the Azure documentation and developer community for providing excellent learning resources.

---

# Author

**Aditya Bhatt**

GitHub: https://github.com/AdityaBhatt3010

Project:

Azure Script Engine

Cross-platform Azure administration toolkit built using Bash, PowerShell, and Azure CLI.

---

# Final Notes

Azure Script Engine was created as a practical learning project to simplify Azure administration while reinforcing Azure CLI concepts through real-world automation tasks.

---
The project emphasizes readability, consistency, and modularity so that each script can serve as both a useful administration utility and a learning resource.

Thank you for checking out Azure Script Engine.

---
