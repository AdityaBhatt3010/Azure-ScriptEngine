# ==========================================================
# Azure Script Engine
# Azure CLI Setup & Account Management (Windows)
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
    Write-Host " Azure CLI Setup & Account Management"
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
        Write-Host ""
        Write-Host "Select option 1 to install Azure CLI."
        Pause-Script

        return $false
    }

    return $true
}

# ------------------------------
# Install Azure CLI
# ------------------------------
function Install-AzureCLI {

    Show-Header

    if (Get-Command az -ErrorAction SilentlyContinue) {

        Write-Host "Azure CLI is already installed."
        Write-Host ""

        az version

        Pause-Script
        return
    }

    Write-Host "Installing Azure CLI..."
    Write-Host ""

    if (Get-Command winget -ErrorAction SilentlyContinue) {

        winget install Microsoft.AzureCLI

    }
    else {

        Write-Host "Winget is not available."
        Write-Host "Install Azure CLI manually."

    }

    Pause-Script
}

# ------------------------------
# Login
# ------------------------------
function Login-Azure {

    Show-Header

    if (-not (Test-AzureCLI)) { return }

    az login

    Pause-Script
}

# ------------------------------
# Logout
# ------------------------------
function Logout-Azure {

    Show-Header

    if (-not (Test-AzureCLI)) { return }

    az logout

    Write-Host ""
    Write-Host "Logged out successfully."

    Pause-Script
}

# ------------------------------
# Azure CLI Version
# ------------------------------
function Show-Version {

    Show-Header

    if (-not (Test-AzureCLI)) { return }

    az version

    Pause-Script
}

# ------------------------------
# Show Current Account
# ------------------------------
function Show-CurrentAccount {

    Show-Header

    if (-not (Test-AzureCLI)) { return }

    az account show --output table

    Pause-Script
}

# ------------------------------
# List Subscriptions
# ------------------------------
function List-Subscriptions {

    Show-Header

    if (-not (Test-AzureCLI)) { return }

    az account list --output table

    Pause-Script
}

# ------------------------------
# Switch Subscription
# ------------------------------
function Switch-Subscription {

    Show-Header

    if (-not (Test-AzureCLI)) { return }

    az account list --output table

    Write-Host ""

    $subscription = Read-Host "Enter Subscription Name or ID"

    if ([string]::IsNullOrWhiteSpace($subscription)) {

        Write-Host ""
        Write-Host "Subscription cannot be empty."

        Pause-Script
        return
    }

    az account set --subscription "$subscription"

    if ($LASTEXITCODE -eq 0) {

        Write-Host ""
        Write-Host "Subscription changed successfully."
        Write-Host ""

        az account show --output table

    }
    else {

        Write-Host ""
        Write-Host "Unable to switch subscription."

    }

    Pause-Script
}

# ------------------------------
# Main Menu
# ------------------------------
function Show-Menu {

    while ($true) {

        Show-Header

        Write-Host "1. Install Azure CLI"
        Write-Host "2. Login to Azure"
        Write-Host "3. Show Current Account"
        Write-Host "4. List Subscriptions"
        Write-Host "5. Switch Subscription"
        Write-Host "6. Check Azure CLI Version"
        Write-Host "7. Logout"
        Write-Host "8. Exit"
        Write-Host ""

        $choice = Read-Host "Enter your choice"

        switch ($choice) {

            "1" { Install-AzureCLI }

            "2" { Login-Azure }

            "3" { Show-CurrentAccount }

            "4" { List-Subscriptions }

            "5" { Switch-Subscription }

            "6" { Show-Version }

            "7" { Logout-Azure }

            "8" {

                Clear-Host
                Write-Host "Thank you for using Azure Script Engine."
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
# Start
# ------------------------------

Show-Menu
