#!/bin/bash

# ==========================================================
# Azure Script Engine
# Azure Resource Group Management (Linux)
# Version : 1.0
# ==========================================================

# ------------------------------
# Pause Function
# ------------------------------
pause() {
    read -rp "Press Enter to continue..."
}

# ------------------------------
# Header
# ------------------------------
header() {
    clear
    echo "=================================================="
    echo "             Azure Script Engine"
    echo "=================================================="
    echo " Azure Resource Group Management"
    echo "=================================================="
    echo
}

# ------------------------------
# Azure CLI Check
# ------------------------------
check_cli() {

    if ! command -v az >/dev/null 2>&1
    then
        echo
        echo "Azure CLI is not installed."
        echo "Run Azure CLI Setup first."
        echo
        pause
        return 1
    fi

    return 0
}

# ------------------------------
# Login Check
# ------------------------------
check_login() {

    az account show >/dev/null 2>&1

    if [ $? -ne 0 ]
    then
        echo
        echo "You are not logged in."
        echo "Please login using Azure CLI Setup."
        echo
        pause
        return 1
    fi

    return 0
}

# ------------------------------
# Create Resource Group
# ------------------------------
create_rg() {

    header

    check_cli || return
    check_login || return

    echo "Create Resource Group"
    echo "--------------------------------------------------"
    echo

    read -rp "Resource Group Name : " RGNAME

    if [[ -z "$RGNAME" ]]
    then
        echo
        echo "Resource Group name cannot be empty."
        pause
        return
    fi

    echo
    echo "Suggested Locations"
    echo
    echo "1. centralindia"
    echo "2. southindia"
    echo "3. eastus"
    echo "4. westus"
    echo "5. uksouth"
    echo

    read -rp "Location : " LOCATION

    if [[ -z "$LOCATION" ]]
    then
        echo
        echo "Location cannot be empty."
        pause
        return
    fi

    echo
    echo "Creating Resource Group..."
    echo

    az group create \
        --name "$RGNAME" \
        --location "$LOCATION" \
        --output table

    if [ $? -eq 0 ]
    then
        echo
        echo "Resource Group created successfully."
    else
        echo
        echo "Failed to create Resource Group."
    fi

    echo
    pause
}

# ------------------------------
# List Resource Groups
# ------------------------------
list_rg() {

    header

    check_cli || return
    check_login || return

    echo "Available Resource Groups"
    echo "--------------------------------------------------"
    echo

    az group list --output table

    echo
    pause
}

# ------------------------------
# Show Resource Group Details
# ------------------------------
show_rg() {

    header

    check_cli || return
    check_login || return

    read -rp "Enter Resource Group Name : " RGNAME

    if [[ -z "$RGNAME" ]]
    then
        echo
        echo "Resource Group name cannot be empty."
        pause
        return
    fi

    echo

    az group show \
        --name "$RGNAME" \
        --output table

    echo
    pause
}

# ------------------------------
# Delete Resource Group
# ------------------------------
delete_rg() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group Name : " RGNAME

    if [[ -z "$RGNAME" ]]
    then
        echo
        echo "Resource Group name cannot be empty."
        pause
        return
    fi

    echo
    echo "WARNING"
    echo "This operation will delete the Resource Group"
    echo "along with all resources inside it."
    echo

    read -rp "Continue? (Y/N): " CHOICE

    case "$CHOICE" in
        Y|y)

            az group delete \
                --name "$RGNAME" \
                --yes

            echo
            echo "Delete request submitted."
            ;;

        *)

            echo
            echo "Operation cancelled."
            ;;
    esac

    echo
    pause
}

# ------------------------------
# Deployment History
# ------------------------------
deployment_history() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group Name : " RGNAME

    if [[ -z "$RGNAME" ]]
    then
        echo
        echo "Resource Group name cannot be empty."
        pause
        return
    fi

    echo

    az deployment group list \
        --resource-group "$RGNAME" \
        --output table

    echo
    pause
}

# ------------------------------
# List Azure Locations
# ------------------------------
list_locations() {

    header

    check_cli || return
    check_login || return

    echo "Available Azure Locations"
    echo "--------------------------------------------------"
    echo

    az account list-locations \
        --output table

    echo
    pause
}

# ------------------------------
# Check Resource Group Exists
# ------------------------------
resource_group_exists() {

    check_cli || return 1
    check_login || return 1

    read -rp "Resource Group Name : " RGNAME

    if [[ -z "$RGNAME" ]]
    then
        echo
        echo "Resource Group name cannot be empty."
        pause
        return
    fi

    echo

    EXISTS=$(az group exists --name "$RGNAME")

    if [[ "$EXISTS" == "true" ]]
    then
        echo "Resource Group exists."
    else
        echo "Resource Group does not exist."
    fi

    echo
    pause
}

# ------------------------------
# Main Menu
# ------------------------------
menu() {

    while true
    do

        header

        echo "1. Create Resource Group"
        echo "2. List Resource Groups"
        echo "3. Show Resource Group Details"
        echo "4. Delete Resource Group"
        echo "5. Deployment History"
        echo "6. List Azure Locations"
        echo "7. Check Resource Group Exists"
        echo "8. Exit"
        echo

        read -rp "Enter your choice: " choice

        case $choice in

            1)
                create_rg
                ;;

            2)
                list_rg
                ;;

            3)
                show_rg
                ;;

            4)
                delete_rg
                ;;

            5)
                deployment_history
                ;;

            6)
                list_locations
                ;;

            7)
                resource_group_exists
                ;;

            8)

                clear
                echo
                echo "Thank you for using Azure Script Engine."
                echo
                exit 0
                ;;

            *)

                echo
                echo "Invalid choice."
                pause
                ;;
        esac

    done
}

# ------------------------------
# Start Script
# ------------------------------
menu
