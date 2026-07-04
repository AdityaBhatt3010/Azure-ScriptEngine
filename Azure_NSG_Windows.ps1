# ==========================================================
# Azure Script Engine
# Azure Network Security Group Management (Windows)
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
    Write-Host " Azure Network Security Group Management"
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
# Create NSG
# ------------------------------
function Create-NSG {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Create Network Security Group"
    Write-Host "--------------------------------------------------"
    Write-Host ""

    $RG = Read-Host "Resource Group"
    $NSG = Read-Host "NSG Name"
    $Location = Read-Host "Location"

    az network nsg create `
        --resource-group $RG `
        --name $NSG `
        --location $Location `
        --output table

    Pause-Script
}

# ------------------------------
# List NSGs
# ------------------------------
function List-NSGs {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    az network nsg list --output table

    Pause-Script
}

# ------------------------------
# Show NSG Details
# ------------------------------
function Show-NSG {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $NSG = Read-Host "NSG Name"

    az network nsg show `
        --resource-group $RG `
        --name $NSG `
        --output table

    Pause-Script
}

# ------------------------------
# Delete NSG
# ------------------------------
function Remove-NSG {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $NSG = Read-Host "NSG Name"

    Write-Host ""
    $Confirm = Read-Host "Delete this NSG? (Y/N)"

    if ($Confirm -match "^[Yy]$") {

        az network nsg delete `
            --resource-group $RG `
            --name $NSG

        Write-Host ""
        Write-Host "NSG deleted."

    }
    else {

        Write-Host ""
        Write-Host "Operation cancelled."

    }

    Pause-Script
}

# ------------------------------
# Create Security Rule
# ------------------------------
function Create-NSGRule {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Create Security Rule"
    Write-Host "--------------------------------------------------"
    Write-Host ""

    $RG = Read-Host "Resource Group"
    $NSG = Read-Host "NSG Name"
    $Rule = Read-Host "Rule Name"
    $Priority = Read-Host "Priority (100-4096)"

    Write-Host ""
    Write-Host "Direction"
    Write-Host "1. Inbound"
    Write-Host "2. Outbound"

    $DirectionChoice = Read-Host "Choice"

    switch ($DirectionChoice) {

        "1" { $Direction = "Inbound" }

        "2" { $Direction = "Outbound" }

        default {

            Write-Host ""
            Write-Host "Invalid option."

            Pause-Script
            return
        }
    }

    Write-Host ""
    Write-Host "Access"
    Write-Host "1. Allow"
    Write-Host "2. Deny"

    $AccessChoice = Read-Host "Choice"

    switch ($AccessChoice) {

        "1" { $Access = "Allow" }

        "2" { $Access = "Deny" }

        default {

            Write-Host ""
            Write-Host "Invalid option."

            Pause-Script
            return
        }
    }

    $Protocol = Read-Host "Protocol (Tcp/Udp/*)"
    $Port = Read-Host "Destination Port"

    az network nsg rule create `
        --resource-group $RG `
        --nsg-name $NSG `
        --name $Rule `
        --priority $Priority `
        --direction $Direction `
        --access $Access `
        --protocol $Protocol `
        --destination-port-ranges $Port `
        --output table

    Pause-Script
}

# ------------------------------
# List Security Rules
# ------------------------------
function List-NSGRules {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $NSG = Read-Host "NSG Name"

    az network nsg rule list `
        --resource-group $RG `
        --nsg-name $NSG `
        --output table

    Pause-Script
}

# ------------------------------
# Delete Security Rule
# ------------------------------
function Remove-NSGRule {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $NSG = Read-Host "NSG Name"
    $Rule = Read-Host "Rule Name"

    Write-Host ""
    $Confirm = Read-Host "Delete this Security Rule? (Y/N)"

    if ($Confirm -match "^[Yy]$") {

        az network nsg rule delete `
            --resource-group $RG `
            --nsg-name $NSG `
            --name $Rule

        Write-Host ""
        Write-Host "Security Rule deleted."

    }
    else {

        Write-Host ""
        Write-Host "Operation cancelled."

    }

    Pause-Script
}

# ------------------------------
# Associate NSG to Subnet
# ------------------------------
function Associate-NSGToSubnet {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VNet = Read-Host "Virtual Network"
    $Subnet = Read-Host "Subnet Name"
    $NSG = Read-Host "NSG Name"

    az network vnet subnet update `
        --resource-group $RG `
        --vnet-name $VNet `
        --name $Subnet `
        --network-security-group $NSG `
        --output table

    Pause-Script
}

# ------------------------------
# Associate NSG to NIC
# ------------------------------
function Associate-NSGToNIC {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $NIC = Read-Host "NIC Name"
    $NSG = Read-Host "NSG Name"

    az network nic update `
        --resource-group $RG `
        --name $NIC `
        --network-security-group $NSG `
        --output table

    Pause-Script
}

# ------------------------------
# Remove NSG Association
# ------------------------------
function Remove-NSGAssociation {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Remove NSG Association"
    Write-Host ""
    Write-Host "1. From Subnet"
    Write-Host "2. From Network Interface"
    Write-Host ""

    $Choice = Read-Host "Choice"

    switch ($Choice) {

        "1" {

            $RG = Read-Host "Resource Group"
            $VNet = Read-Host "Virtual Network"
            $Subnet = Read-Host "Subnet Name"

            az network vnet subnet update `
                --resource-group $RG `
                --vnet-name $VNet `
                --name $Subnet `
                --remove networkSecurityGroup
        }

        "2" {

            $RG = Read-Host "Resource Group"
            $NIC = Read-Host "NIC Name"

            az network nic update `
                --resource-group $RG `
                --name $NIC `
                --remove networkSecurityGroup
        }

        default {

            Write-Host ""
            Write-Host "Invalid option."

            Pause-Script
            return
        }
    }

    Write-Host ""
    Write-Host "Association removed."

    Pause-Script
}

# ------------------------------
# Main Menu
# ------------------------------
function Show-Menu {

    while ($true) {

        Show-Header

        Write-Host "1. Create NSG"
        Write-Host "2. List NSGs"
        Write-Host "3. Show NSG"
        Write-Host "4. Delete NSG"
        Write-Host "5. Create Security Rule"
        Write-Host "6. List Security Rules"
        Write-Host "7. Delete Security Rule"
        Write-Host "8. Associate NSG to Subnet"
        Write-Host "9. Associate NSG to NIC"
        Write-Host "10. Remove NSG Association"
        Write-Host "11. Exit"
        Write-Host ""

        $Choice = Read-Host "Enter your choice"

        switch ($Choice) {

            "1" { Create-NSG }

            "2" { List-NSGs }

            "3" { Show-NSG }

            "4" { Remove-NSG }

            "5" { Create-NSGRule }

            "6" { List-NSGRules }

            "7" { Remove-NSGRule }

            "8" { Associate-NSGToSubnet }

            "9" { Associate-NSGToNIC }

            "10" { Remove-NSGAssociation }

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
