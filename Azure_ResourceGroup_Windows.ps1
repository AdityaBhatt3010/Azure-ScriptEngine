# ==========================================================
# Azure Script Engine
# Azure Resource Group Management (Windows)
# Version : 1.0
# ==========================================================

# ------------------------------
# Pause Function
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
    Write-Host " Azure Resource Group Management"
    Write-Host "=================================================="
    Write-Host ""
}

# ------------------------------
# Azure CLI Check
# ------------------------------
function Test-AzureCLI {

    $cli = Get-Command az -ErrorAction SilentlyContinue

    if (-not $cli) {

        Write-Host ""
        Write-Host "Azure CLI is not installed."
        Write-Host "Run Azure CLI Setup first."

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
        Write-Host "You are not logged in."
        Write-Host "Please login first."

        Pause-Script

        return $false
    }

    return $true
}

# ------------------------------
# Create Resource Group
# ------------------------------
function Create-ResourceGroup {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Create Resource Group"
    Write-Host "--------------------------------------------------"
    Write-Host ""

    $RGName = Read-Host "Resource Group Name"

    if ([string]::IsNullOrWhiteSpace($RGName)) {

        Write-Host ""
        Write-Host "Resource Group name cannot be empty."

        Pause-Script
        return
    }

    Write-Host ""
    Write-Host "Suggested Locations"
    Write-Host ""
    Write-Host "1. centralindia"
    Write-Host "2. southindia"
    Write-Host "3. eastus"
    Write-Host "4. westus"
    Write-Host "5. uksouth"
    Write-Host ""

    $Location = Read-Host "Location"

    if ([string]::IsNullOrWhiteSpace($Location)) {

        Write-Host ""
        Write-Host "Location cannot be empty."

        Pause-Script
        return
    }

    Write-Host ""
    Write-Host "Creating Resource Group..."
    Write-Host ""

    az group create `
        --name $RGName `
        --location $Location `
        --output table

    if ($LASTEXITCODE -eq 0) {

        Write-Host ""
        Write-Host "Resource Group created successfully."

    }
    else {

        Write-Host ""
        Write-Host "Failed to create Resource Group."

    }

    Pause-Script
}

# ------------------------------
# List Resource Groups
# ------------------------------
function List-ResourceGroups {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    az group list --output table

    Pause-Script
}

# ------------------------------
# Show Resource Group Details
# ------------------------------
function Show-ResourceGroup {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RGName = Read-Host "Resource Group Name"

    if ([string]::IsNullOrWhiteSpace($RGName)) {

        Write-Host ""
        Write-Host "Resource Group name cannot be empty."

        Pause-Script
        return
    }

    Write-Host ""

    az group show `
        --name $RGName `
        --output table

    Pause-Script
}

# ------------------------------
# Delete Resource Group
# ------------------------------
function Remove-ResourceGroup {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RGName = Read-Host "Resource Group Name"

    if ([string]::IsNullOrWhiteSpace($RGName)) {

        Write-Host ""
        Write-Host "Resource Group name cannot be empty."

        Pause-Script
        return
    }

    Write-Host ""
    Write-Host "WARNING"
    Write-Host "This will delete the Resource Group"
    Write-Host "and all resources inside it."
    Write-Host ""

    $Choice = Read-Host "Continue? (Y/N)"

    if ($Choice -match "^[Yy]$") {

        az group delete `
            --name $RGName `
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
# Deployment History
# ------------------------------
function Show-DeploymentHistory {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RGName = Read-Host "Resource Group Name"

    if ([string]::IsNullOrWhiteSpace($RGName)) {

        Write-Host ""
        Write-Host "Resource Group name cannot be empty."

        Pause-Script
        return
    }

    Write-Host ""

    az deployment group list `
        --resource-group $RGName `
        --output table

    Pause-Script
}

# ------------------------------
# List Azure Locations
# ------------------------------
function Show-AzureLocations {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    az account list-locations --output table

    Pause-Script
}

# ------------------------------
# Check Resource Group Exists
# ------------------------------
function Test-ResourceGroup {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RGName = Read-Host "Resource Group Name"

    if ([string]::IsNullOrWhiteSpace($RGName)) {

        Write-Host ""
        Write-Host "Resource Group name cannot be empty."

        Pause-Script
        return
    }

    $Exists = az group exists --name $RGName

    Write-Host ""

    if ($Exists -eq "true") {

        Write-Host "Resource Group exists."

    }
    else {

        Write-Host "Resource Group does not exist."

    }

    Pause-Script
}

# ------------------------------
# Main Menu
# ------------------------------
function Show-Menu {

    while ($true) {

        Show-Header

        Write-Host "1. Create Resource Group"
        Write-Host "2. List Resource Groups"
        Write-Host "3. Show Resource Group Details"
        Write-Host "4. Delete Resource Group"
        Write-Host "5. Deployment History"
        Write-Host "6. List Azure Locations"
        Write-Host "7. Check Resource Group Exists"
        Write-Host "8. Exit"
        Write-Host ""

        $Choice = Read-Host "Enter your choice"

        switch ($Choice) {

            "1" {
                Create-ResourceGroup
            }

            "2" {
                List-ResourceGroups
            }

            "3" {
                Show-ResourceGroup
            }

            "4" {
                Remove-ResourceGroup
            }

            "5" {
                Show-DeploymentHistory
            }

            "6" {
                Show-AzureLocations
            }

            "7" {
                Test-ResourceGroup
            }

            "8" {

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
