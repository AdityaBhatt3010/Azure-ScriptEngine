# ==========================================================
# Azure Script Engine
# Azure Virtual Machine Management (Windows)
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
    Write-Host " Azure Virtual Machine Management"
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
        Write-Host "You are not logged in."

        Pause-Script
        return $false
    }

    return $true
}

# ------------------------------
# Create Virtual Machine
# ------------------------------
function Create-VM {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    Write-Host "Create Virtual Machine"
    Write-Host "--------------------------------------------------"
    Write-Host ""

    $RG = Read-Host "Resource Group"

    if ([string]::IsNullOrWhiteSpace($RG)) {

        Write-Host ""
        Write-Host "Resource Group cannot be empty."

        Pause-Script
        return
    }

    $VM = Read-Host "VM Name"

    if ([string]::IsNullOrWhiteSpace($VM)) {

        Write-Host ""
        Write-Host "VM Name cannot be empty."

        Pause-Script
        return
    }

    Write-Host ""
    Write-Host "Choose Image"
    Write-Host ""
    Write-Host "1. Ubuntu 24.04 LTS"
    Write-Host "2. Ubuntu 22.04 LTS"
    Write-Host "3. Windows Server 2022"
    Write-Host ""

    $ImageChoice = Read-Host "Choice"

    switch ($ImageChoice) {

        "1" { $Image = "Ubuntu2404" }

        "2" { $Image = "Ubuntu2204" }

        "3" { $Image = "Win2022Datacenter" }

        default {

            Write-Host ""
            Write-Host "Invalid choice."

            Pause-Script
            return
        }
    }

    Write-Host ""
    Write-Host "Common VM Sizes"
    Write-Host ""
    Write-Host "1. Standard_B1s"
    Write-Host "2. Standard_B2s"
    Write-Host "3. Standard_D2s_v5"
    Write-Host ""

    $SizeChoice = Read-Host "Choice"

    switch ($SizeChoice) {

        "1" { $Size = "Standard_B1s" }

        "2" { $Size = "Standard_B2s" }

        "3" { $Size = "Standard_D2s_v5" }

        default {

            Write-Host ""
            Write-Host "Invalid choice."

            Pause-Script
            return
        }
    }

    $Username = Read-Host "Admin Username"

    if ([string]::IsNullOrWhiteSpace($Username)) {

        Write-Host ""
        Write-Host "Username cannot be empty."

        Pause-Script
        return
    }

    Write-Host ""
    Write-Host "Authentication"
    Write-Host ""
    Write-Host "1. SSH Key"
    Write-Host "2. Password"
    Write-Host ""

    $Auth = Read-Host "Choice"

    if ($Auth -eq "1") {

        az vm create `
            --resource-group $RG `
            --name $VM `
            --image $Image `
            --size $Size `
            --admin-username $Username `
            --generate-ssh-keys `
            --output table

    }
    elseif ($Auth -eq "2") {

        $Password = Read-Host "Password"

        az vm create `
            --resource-group $RG `
            --name $VM `
            --image $Image `
            --size $Size `
            --admin-username $Username `
            --admin-password $Password `
            --authentication-type password `
            --output table

    }
    else {

        Write-Host ""
        Write-Host "Invalid option."

        Pause-Script
        return
    }

    Write-Host ""

    if ($LASTEXITCODE -eq 0) {

        Write-Host "Virtual Machine created successfully."

    }
    else {

        Write-Host "Failed to create Virtual Machine."

    }

    Pause-Script
}

# ------------------------------
# List Virtual Machines
# ------------------------------
function List-VM {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    az vm list -d --output table

    Pause-Script
}

# ------------------------------
# Start Virtual Machine
# ------------------------------
function Start-VM {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VM = Read-Host "VM Name"

    az vm start `
        --resource-group $RG `
        --name $VM

    Write-Host ""
    Write-Host "Start request submitted."

    Pause-Script
}

# ------------------------------
# Stop Virtual Machine
# ------------------------------
function Stop-VM {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VM = Read-Host "VM Name"

    az vm stop `
        --resource-group $RG `
        --name $VM

    Write-Host ""
    Write-Host "Stop request submitted."

    Pause-Script
}

# ------------------------------
# Restart Virtual Machine
# ------------------------------
function Restart-VM {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VM = Read-Host "VM Name"

    az vm restart `
        --resource-group $RG `
        --name $VM

    Write-Host ""
    Write-Host "Restart request submitted."

    Pause-Script
}

# ------------------------------
# Deallocate Virtual Machine
# ------------------------------
function Deallocate-VM {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VM = Read-Host "VM Name"

    az vm deallocate `
        --resource-group $RG `
        --name $VM

    Write-Host ""
    Write-Host "Virtual Machine deallocated."

    Pause-Script
}

# ------------------------------
# Show Virtual Machine Details
# ------------------------------
function Show-VMDetails {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VM = Read-Host "VM Name"

    az vm show `
        --resource-group $RG `
        --name $VM `
        --show-details `
        --output table

    Pause-Script
}

# ------------------------------
# Delete Virtual Machine
# ------------------------------
function Remove-VM {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $RG = Read-Host "Resource Group"
    $VM = Read-Host "VM Name"

    Write-Host ""
    Write-Host "WARNING"
    Write-Host "This will permanently delete the Virtual Machine."
    Write-Host ""

    $Choice = Read-Host "Continue? (Y/N)"

    if ($Choice -match "^[Yy]$") {

        az vm delete `
            --resource-group $RG `
            --name $VM `
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
# List Available VM Sizes
# ------------------------------
function List-VMSizes {

    Show-Header

    if (-not (Test-AzureCLI)) { return }
    if (-not (Test-AzureLogin)) { return }

    $Location = Read-Host "Location"

    if ([string]::IsNullOrWhiteSpace($Location)) {

        Write-Host ""
        Write-Host "Location cannot be empty."

        Pause-Script
        return
    }

    az vm list-sizes `
        --location $Location `
        --output table

    Pause-Script
}

# ------------------------------
# Main Menu
# ------------------------------
function Show-Menu {

    while ($true) {

        Show-Header

        Write-Host "1. Create Virtual Machine"
        Write-Host "2. List Virtual Machines"
        Write-Host "3. Start Virtual Machine"
        Write-Host "4. Stop Virtual Machine"
        Write-Host "5. Restart Virtual Machine"
        Write-Host "6. Deallocate Virtual Machine"
        Write-Host "7. Show Virtual Machine Details"
        Write-Host "8. Delete Virtual Machine"
        Write-Host "9. List Available VM Sizes"
        Write-Host "10. Exit"
        Write-Host ""

        $Choice = Read-Host "Enter your choice"

        switch ($Choice) {

            "1" { Create-VM }

            "2" { List-VM }

            "3" { Start-VM }

            "4" { Stop-VM }

            "5" { Restart-VM }

            "6" { Deallocate-VM }

            "7" { Show-VMDetails }

            "8" { Remove-VM }

            "9" { List-VMSizes }

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
