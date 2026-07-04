# ==========================================================
# Azure Script Engine
# Azure Virtual Network Management (Windows)
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
    Write-Host " Azure Virtual Network Management"
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
# Create Virtual Network
# ------------------------------
function Create-VNet {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Create Virtual Network"
    Write-Host "--------------------------------------------------"
    Write-Host ""

    $RG = Read-Host "Resource Group"
    $VNet = Read-Host "Virtual Network Name"
    $Location = Read-Host "Location"
    $Address = Read-Host "Address Space (Example 10.0.0.0/16)"

    az network vnet create `
        --resource-group $RG `
        --name $VNet `
        --location $Location `
        --address-prefixes $Address `
        --output table

    Pause-Script
}

# ------------------------------
# List Virtual Networks
# ------------------------------
function List-VNets {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    az network vnet list --output table

    Pause-Script
}

# ------------------------------
# Show Virtual Network
# ------------------------------
function Show-VNet {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VNet = Read-Host "Virtual Network"

    az network vnet show `
        --resource-group $RG `
        --name $VNet `
        --output table

    Pause-Script
}

# ------------------------------
# Delete Virtual Network
# ------------------------------
function Remove-VNet {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VNet = Read-Host "Virtual Network"

    Write-Host ""
    $Confirm = Read-Host "Delete this Virtual Network? (Y/N)"

    if ($Confirm -match "^[Yy]$") {

        az network vnet delete `
            --resource-group $RG `
            --name $VNet

        Write-Host ""
        Write-Host "Virtual Network deleted."

    }
    else {

        Write-Host ""
        Write-Host "Operation cancelled."

    }

    Pause-Script
}

# ------------------------------
# Create Subnet
# ------------------------------
function Create-Subnet {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Create Subnet"
    Write-Host "--------------------------------------------------"
    Write-Host ""

    $RG = Read-Host "Resource Group"
    $VNet = Read-Host "Virtual Network"
    $Subnet = Read-Host "Subnet Name"
    $Prefix = Read-Host "Address Prefix (Example 10.0.1.0/24)"

    az network vnet subnet create `
        --resource-group $RG `
        --vnet-name $VNet `
        --name $Subnet `
        --address-prefixes $Prefix `
        --output table

    Pause-Script
}

# ------------------------------
# List Subnets
# ------------------------------
function List-Subnets {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VNet = Read-Host "Virtual Network"

    az network vnet subnet list `
        --resource-group $RG `
        --vnet-name $VNet `
        --output table

    Pause-Script
}

# ------------------------------
# Show Subnet
# ------------------------------
function Show-Subnet {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VNet = Read-Host "Virtual Network"
    $Subnet = Read-Host "Subnet Name"

    az network vnet subnet show `
        --resource-group $RG `
        --vnet-name $VNet `
        --name $Subnet `
        --output table

    Pause-Script
}

# ------------------------------
# Delete Subnet
# ------------------------------
function Remove-Subnet {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VNet = Read-Host "Virtual Network"
    $Subnet = Read-Host "Subnet Name"

    Write-Host ""
    $Confirm = Read-Host "Delete this Subnet? (Y/N)"

    if ($Confirm -match "^[Yy]$") {

        az network vnet subnet delete `
            --resource-group $RG `
            --vnet-name $VNet `
            --name $Subnet

        Write-Host ""
        Write-Host "Subnet deleted."

    }
    else {

        Write-Host ""
        Write-Host "Operation cancelled."

    }

    Pause-Script
}

# ------------------------------
# Create VNet Peering
# ------------------------------
function Create-VNetPeering {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Create VNet Peering"
    Write-Host "--------------------------------------------------"
    Write-Host ""

    $RG = Read-Host "Resource Group"
    $Source = Read-Host "Source Virtual Network"
    $Peering = Read-Host "Peering Name"
    $Target = Read-Host "Target VNet Resource ID"

    az network vnet peering create `
        --resource-group $RG `
        --vnet-name $Source `
        --name $Peering `
        --remote-vnet $Target `
        --allow-vnet-access `
        --output table

    Pause-Script
}

# ------------------------------
# List VNet Peerings
# ------------------------------
function List-VNetPeerings {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VNet = Read-Host "Virtual Network"

    az network vnet peering list `
        --resource-group $RG `
        --vnet-name $VNet `
        --output table

    Pause-Script
}

# ------------------------------
# Main Menu
# ------------------------------
function Show-Menu {

    while ($true) {

        Show-Header

        Write-Host "1. Create Virtual Network"
        Write-Host "2. List Virtual Networks"
        Write-Host "3. Show Virtual Network"
        Write-Host "4. Delete Virtual Network"
        Write-Host "5. Create Subnet"
        Write-Host "6. List Subnets"
        Write-Host "7. Show Subnet"
        Write-Host "8. Delete Subnet"
        Write-Host "9. Create VNet Peering"
        Write-Host "10. List VNet Peerings"
        Write-Host "11. Exit"
        Write-Host ""

        $Choice = Read-Host "Enter your choice"

        switch ($Choice) {

            "1" { Create-VNet }

            "2" { List-VNets }

            "3" { Show-VNet }

            "4" { Remove-VNet }

            "5" { Create-Subnet }

            "6" { List-Subnets }

            "7" { Show-Subnet }

            "8" { Remove-Subnet }

            "9" { Create-VNetPeering }

            "10" { List-VNetPeerings }

            "11" {

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
