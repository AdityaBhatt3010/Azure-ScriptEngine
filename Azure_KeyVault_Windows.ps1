# ==========================================================
# Azure Script Engine
# Azure Key Vault Management (Windows)
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
    Write-Host " Azure Key Vault Management"
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
# Create Key Vault
# ------------------------------
function Create-KeyVault {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Create Key Vault"
    Write-Host "--------------------------------------------------"
    Write-Host ""

    $RG = Read-Host "Resource Group"
    $Vault = Read-Host "Key Vault Name"
    $Location = Read-Host "Location"

    az keyvault create `
        --resource-group $RG `
        --name $Vault `
        --location $Location `
        --output table

    Pause-Script
}

# ------------------------------
# List Key Vaults
# ------------------------------
function List-KeyVaults {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    az keyvault list --output table

    Pause-Script
}

# ------------------------------
# Show Key Vault
# ------------------------------
function Show-KeyVault {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $Vault = Read-Host "Key Vault Name"

    az keyvault show `
        --name $Vault `
        --output table

    Pause-Script
}

# ------------------------------
# Delete Key Vault
# ------------------------------
function Remove-KeyVault {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $Vault = Read-Host "Key Vault Name"

    Write-Host ""
    $Confirm = Read-Host "Delete this Key Vault? (Y/N)"

    if ($Confirm -match "^[Yy]$") {

        az keyvault delete `
            --name $Vault

        Write-Host ""
        Write-Host "Key Vault deleted."

    }
    else {

        Write-Host ""
        Write-Host "Operation cancelled."

    }

    Pause-Script
}

# ------------------------------
# Create Secret
# ------------------------------
function Create-Secret {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Create Secret"
    Write-Host "--------------------------------------------------"
    Write-Host ""

    $Vault = Read-Host "Key Vault Name"
    $Secret = Read-Host "Secret Name"
    $Value = Read-Host "Secret Value"

    az keyvault secret set `
        --vault-name $Vault `
        --name $Secret `
        --value $Value `
        --output table

    Pause-Script
}

# ==========================================================
# Azure Script Engine
# Azure Key Vault Management (Windows)
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
    Write-Host " Azure Key Vault Management"
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
# Create Key Vault
# ------------------------------
function Create-KeyVault {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Create Key Vault"
    Write-Host "--------------------------------------------------"
    Write-Host ""

    $RG = Read-Host "Resource Group"
    $Vault = Read-Host "Key Vault Name"
    $Location = Read-Host "Location"

    az keyvault create `
        --resource-group $RG `
        --name $Vault `
        --location $Location `
        --output table

    Pause-Script
}

# ------------------------------
# List Key Vaults
# ------------------------------
function List-KeyVaults {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    az keyvault list --output table

    Pause-Script
}

# ------------------------------
# Show Key Vault
# ------------------------------
function Show-KeyVault {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $Vault = Read-Host "Key Vault Name"

    az keyvault show `
        --name $Vault `
        --output table

    Pause-Script
}

# ------------------------------
# Delete Key Vault
# ------------------------------
function Remove-KeyVault {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $Vault = Read-Host "Key Vault Name"

    Write-Host ""
    $Confirm = Read-Host "Delete this Key Vault? (Y/N)"

    if ($Confirm -match "^[Yy]$") {

        az keyvault delete `
            --name $Vault

        Write-Host ""
        Write-Host "Key Vault deleted."

    }
    else {

        Write-Host ""
        Write-Host "Operation cancelled."

    }

    Pause-Script
}

# ------------------------------
# Create Secret
# ------------------------------
function Create-Secret {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Create Secret"
    Write-Host "--------------------------------------------------"
    Write-Host ""

    $Vault = Read-Host "Key Vault Name"
    $Secret = Read-Host "Secret Name"
    $Value = Read-Host "Secret Value"

    az keyvault secret set `
        --vault-name $Vault `
        --name $Secret `
        --value $Value `
        --output table

    Pause-Script
}
