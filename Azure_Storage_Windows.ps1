# ==========================================================
# Azure Script Engine
# Azure Storage Management (Windows)
# Version : 1.0
# ==========================================================

# ------------------------------
# Pause
# ------------------------------
function Pause-Script {
    Read-Host "`nPress Enter to continue"
}

# ------------------------------
# Header
# ------------------------------
function Show-Header {

    Clear-Host

    Write-Host "=================================================="
    Write-Host "             Azure Script Engine"
    Write-Host "=================================================="
    Write-Host " Azure Storage Management"
    Write-Host "=================================================="
    Write-Host ""
}

# ------------------------------
# Azure CLI Check
# ------------------------------
function Test-AzureCLI {

    if (-not (Get-Command az -ErrorAction SilentlyContinue)) {

        Write-Host ""
        Write-Host "Azure CLI is not installed."

        Pause-Script
        return $false
    }

    return $true
}

# ------------------------------
# Login Check
# ------------------------------
function Test-AzureLogin {

    az account show *> $null

    if ($LASTEXITCODE -ne 0) {

        Write-Host ""
        Write-Host "Please login to Azure first."

        Pause-Script
        return $false
    }

    return $true
}

# ------------------------------
# Create Storage Account
# ------------------------------
function Create-StorageAccount {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Create Storage Account"
    Write-Host "--------------------------------------------------"
    Write-Host ""

    $RG = Read-Host "Resource Group"
    $Storage = Read-Host "Storage Account Name"
    $Location = Read-Host "Location"

    Write-Host ""
    Write-Host "Storage SKU"
    Write-Host ""
    Write-Host "1. Standard_LRS"
    Write-Host "2. Standard_GRS"
    Write-Host "3. Standard_RAGRS"
    Write-Host "4. Premium_LRS"
    Write-Host ""

    $Choice = Read-Host "Choice"

    switch ($Choice) {

        "1" { $SKU = "Standard_LRS" }
        "2" { $SKU = "Standard_GRS" }
        "3" { $SKU = "Standard_RAGRS" }
        "4" { $SKU = "Premium_LRS" }

        default {

            Write-Host ""
            Write-Host "Invalid option."

            Pause-Script
            return
        }
    }

    az storage account create `
        --resource-group $RG `
        --name $Storage `
        --location $Location `
        --sku $SKU `
        --output table

    Pause-Script
}

# ------------------------------
# List Storage Accounts
# ------------------------------
function List-StorageAccounts {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    az storage account list --output table

    Pause-Script
}

# ------------------------------
# Show Storage Account Details
# ------------------------------
function Show-StorageAccount {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $Storage = Read-Host "Storage Account"

    az storage account show `
        --resource-group $RG `
        --name $Storage `
        --output table

    Pause-Script
}

# ------------------------------
# Delete Storage Account
# ------------------------------
function Remove-StorageAccount {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $Storage = Read-Host "Storage Account"

    Write-Host ""
    $Confirm = Read-Host "Delete this Storage Account? (Y/N)"

    if ($Confirm -match "^[Yy]$") {

        az storage account delete `
            --resource-group $RG `
            --name $Storage `
            --yes

        Write-Host ""
        Write-Host "Delete request submitted."

    }
    else {

        Write-Host ""
        Write-Host "Operation cancelled."

    }

    Pause-Script
}

# ------------------------------
# Create Blob Container
# ------------------------------
function Create-BlobContainer {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $Storage = Read-Host "Storage Account"
    $Container = Read-Host "Container Name"

    $Key = az storage account keys list `
        --account-name $Storage `
        --query "[0].value" `
        -o tsv

    az storage container create `
        --name $Container `
        --account-name $Storage `
        --account-key $Key

    Pause-Script
}

# ------------------------------
# List Blob Containers
# ------------------------------
function List-BlobContainers {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $Storage = Read-Host "Storage Account"

    $Key = az storage account keys list `
        --account-name $Storage `
        --query "[0].value" `
        -o tsv

    az storage container list `
        --account-name $Storage `
        --account-key $Key `
        --output table

    Pause-Script
}

# ------------------------------
# Upload Blob
# ------------------------------
function Upload-Blob {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $Storage = Read-Host "Storage Account"
    $Container = Read-Host "Container Name"
    $File = Read-Host "Local File Path"
    $Blob = Read-Host "Blob Name"

    if (-not (Test-Path $File)) {

        Write-Host ""
        Write-Host "File not found."

        Pause-Script
        return
    }

    $Key = az storage account keys list `
        --account-name $Storage `
        --query "[0].value" `
        -o tsv

    az storage blob upload `
        --account-name $Storage `
        --account-key $Key `
        --container-name $Container `
        --name $Blob `
        --file $File

    Pause-Script
}

# ------------------------------
# Download Blob
# ------------------------------
function Download-Blob {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $Storage = Read-Host "Storage Account"
    $Container = Read-Host "Container Name"
    $Blob = Read-Host "Blob Name"
    $Destination = Read-Host "Download Path"

    $Key = az storage account keys list `
        --account-name $Storage `
        --query "[0].value" `
        -o tsv

    az storage blob download `
        --account-name $Storage `
        --account-key $Key `
        --container-name $Container `
        --name $Blob `
        --file $Destination

    Pause-Script
}

# ------------------------------
# Delete Blob
# ------------------------------
function Remove-Blob {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $Storage = Read-Host "Storage Account"
    $Container = Read-Host "Container Name"
    $Blob = Read-Host "Blob Name"

    Write-Host ""
    $Confirm = Read-Host "Delete this blob? (Y/N)"

    if ($Confirm -match "^[Yy]$") {

        $Key = az storage account keys list `
            --account-name $Storage `
            --query "[0].value" `
            -o tsv

        az storage blob delete `
            --account-name $Storage `
            --account-key $Key `
            --container-name $Container `
            --name $Blob

        Write-Host ""
        Write-Host "Blob deleted."

    }
    else {

        Write-Host ""
        Write-Host "Operation cancelled."

    }

    Pause-Script
}

# ------------------------------
# Main Menu
# ------------------------------
function Show-Menu {

    while ($true) {

        Show-Header

        Write-Host "1. Create Storage Account"
        Write-Host "2. List Storage Accounts"
        Write-Host "3. Show Storage Account Details"
        Write-Host "4. Delete Storage Account"
        Write-Host "5. Create Blob Container"
        Write-Host "6. List Blob Containers"
        Write-Host "7. Upload Blob"
        Write-Host "8. Download Blob"
        Write-Host "9. Delete Blob"
        Write-Host "10. Exit"
        Write-Host ""

        $Choice = Read-Host "Enter your choice"

        switch ($Choice) {

            "1" { Create-StorageAccount }

            "2" { List-StorageAccounts }

            "3" { Show-StorageAccount }

            "4" { Remove-StorageAccount }

            "5" { Create-BlobContainer }

            "6" { List-BlobContainers }

            "7" { Upload-Blob }

            "8" { Download-Blob }

            "9" { Remove-Blob }

            "10" {

                Clear-Host
                Write-Host ""
                Write-Host "Thank you for using Azure Script Engine."
                Write-Host ""

                exit
            }

            default {

                Write-Host ""
                Write-Host "Invalid choice."

                Pause-Script
            }
        }
    }
}

# ------------------------------
# Start Script
# ------------------------------

Show-Menu
