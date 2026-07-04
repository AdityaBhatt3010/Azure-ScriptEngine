#!/bin/bash

# ==========================================================
# Azure Script Engine
# Azure Storage Management (Linux)
# Version : 1.0
# ==========================================================

# ------------------------------
# Pause
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
    echo " Azure Storage Management"
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
        echo "Please login to Azure first."
        pause
        return 1
    fi

    return 0
}

# ------------------------------
# Create Storage Account
# ------------------------------
create_storage() {

    header

    check_cli || return
    check_login || return

    echo "Create Storage Account"
    echo "--------------------------------------------------"
    echo

    read -rp "Resource Group : " RG
    read -rp "Storage Account Name : " STORAGE
    read -rp "Location : " LOCATION

    echo
    echo "Storage SKU"
    echo
    echo "1. Standard_LRS"
    echo "2. Standard_GRS"
    echo "3. Standard_RAGRS"
    echo "4. Premium_LRS"
    echo

    read -rp "Choice : " SKU

    case $SKU in

        1)
            SKU_NAME="Standard_LRS"
            ;;

        2)
            SKU_NAME="Standard_GRS"
            ;;

        3)
            SKU_NAME="Standard_RAGRS"
            ;;

        4)
            SKU_NAME="Premium_LRS"
            ;;

        *)
            echo
            echo "Invalid option."
            pause
            return
            ;;
    esac

    echo
    echo "Creating Storage Account..."
    echo

    az storage account create \
        --resource-group "$RG" \
        --name "$STORAGE" \
        --location "$LOCATION" \
        --sku "$SKU_NAME" \
        --output table

    echo
    pause
}

# ------------------------------
# List Storage Accounts
# ------------------------------
list_storage() {

    header

    check_cli || return
    check_login || return

    az storage account list --output table

    echo
    pause
}

# ------------------------------
# Storage Account Details
# ------------------------------
show_storage() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "Storage Account : " STORAGE

    echo

    az storage account show \
        --resource-group "$RG" \
        --name "$STORAGE" \
        --output table

    echo
    pause
}

# ------------------------------
# Delete Storage Account
# ------------------------------
delete_storage() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "Storage Account : " STORAGE

    echo
    echo "WARNING"
    echo "This will permanently delete the Storage Account."
    echo

    read -rp "Continue? (Y/N): " CHOICE

    case $CHOICE in

        Y|y)

            az storage account delete \
                --resource-group "$RG" \
                --name "$STORAGE" \
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
# Create Blob Container
# ------------------------------
create_container() {

    header

    check_cli || return
    check_login || return

    read -rp "Storage Account : " STORAGE
    read -rp "Container Name : " CONTAINER

    KEY=$(az storage account keys list \
        --account-name "$STORAGE" \
        --query "[0].value" \
        -o tsv)

    az storage container create \
        --name "$CONTAINER" \
        --account-name "$STORAGE" \
        --account-key "$KEY"

    echo
    pause
}

# ------------------------------
# List Blob Containers
# ------------------------------
list_containers() {

    header

    check_cli || return
    check_login || return

    read -rp "Storage Account : " STORAGE

    KEY=$(az storage account keys list \
        --account-name "$STORAGE" \
        --query "[0].value" \
        -o tsv)

    echo

    az storage container list \
        --account-name "$STORAGE" \
        --account-key "$KEY" \
        --output table

    echo
    pause
}

# ------------------------------
# Upload Blob
# ------------------------------
upload_blob() {

    header

    check_cli || return
    check_login || return

    read -rp "Storage Account : " STORAGE
    read -rp "Container Name : " CONTAINER
    read -rp "Local File Path : " FILEPATH
    read -rp "Blob Name : " BLOBNAME

    if [[ ! -f "$FILEPATH" ]]
    then
        echo
        echo "File not found."
        pause
        return
    fi

    KEY=$(az storage account keys list \
        --account-name "$STORAGE" \
        --query "[0].value" \
        -o tsv)

    az storage blob upload \
        --account-name "$STORAGE" \
        --account-key "$KEY" \
        --container-name "$CONTAINER" \
        --name "$BLOBNAME" \
        --file "$FILEPATH"

    echo
    pause
}

# ------------------------------
# Download Blob
# ------------------------------
download_blob() {

    header

    check_cli || return
    check_login || return

    read -rp "Storage Account : " STORAGE
    read -rp "Container Name : " CONTAINER
    read -rp "Blob Name : " BLOBNAME
    read -rp "Download Path : " DOWNLOADPATH

    KEY=$(az storage account keys list \
        --account-name "$STORAGE" \
        --query "[0].value" \
        -o tsv)

    az storage blob download \
        --account-name "$STORAGE" \
        --account-key "$KEY" \
        --container-name "$CONTAINER" \
        --name "$BLOBNAME" \
        --file "$DOWNLOADPATH"

    echo
    pause
}

# ------------------------------
# Delete Blob
# ------------------------------
delete_blob() {

    header

    check_cli || return
    check_login || return

    read -rp "Storage Account : " STORAGE
    read -rp "Container Name : " CONTAINER
    read -rp "Blob Name : " BLOBNAME

    echo
    read -rp "Delete this blob? (Y/N): " CHOICE

    case $CHOICE in

        Y|y)

            KEY=$(az storage account keys list \
                --account-name "$STORAGE" \
                --query "[0].value" \
                -o tsv)

            az storage blob delete \
                --account-name "$STORAGE" \
                --account-key "$KEY" \
                --container-name "$CONTAINER" \
                --name "$BLOBNAME"

            echo
            echo "Blob deleted."
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
# Main Menu
# ------------------------------
menu() {

    while true
    do

        header

        echo "1. Create Storage Account"
        echo "2. List Storage Accounts"
        echo "3. Show Storage Account Details"
        echo "4. Delete Storage Account"
        echo "5. Create Blob Container"
        echo "6. List Blob Containers"
        echo "7. Upload Blob"
        echo "8. Download Blob"
        echo "9. Delete Blob"
        echo "10. Exit"
        echo

        read -rp "Enter your choice: " CHOICE

        case $CHOICE in

            1)
                create_storage
                ;;

            2)
                list_storage
                ;;

            3)
                show_storage
                ;;

            4)
                delete_storage
                ;;

            5)
                create_container
                ;;

            6)
                list_containers
                ;;

            7)
                upload_blob
                ;;

            8)
                download_blob
                ;;

            9)
                delete_blob
                ;;

            10)

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
