#!/bin/bash

# ==========================================================
# Azure Script Engine
# Azure Key Vault Management (Linux)
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
    echo " Azure Key Vault Management"
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
# Create Key Vault
# ------------------------------
create_vault() {

    header

    check_cli || return
    check_login || return

    echo "Create Key Vault"
    echo "--------------------------------------------------"
    echo

    read -rp "Resource Group : " RG
    read -rp "Key Vault Name : " VAULT
    read -rp "Location : " LOCATION

    echo

    az keyvault create \
        --resource-group "$RG" \
        --name "$VAULT" \
        --location "$LOCATION" \
        --output table

    echo
    pause
}

# ------------------------------
# List Key Vaults
# ------------------------------
list_vaults() {

    header

    check_cli || return
    check_login || return

    az keyvault list --output table

    echo
    pause
}

# ------------------------------
# Show Key Vault
# ------------------------------
show_vault() {

    header

    check_cli || return
    check_login || return

    read -rp "Key Vault Name : " VAULT

    echo

    az keyvault show \
        --name "$VAULT" \
        --output table

    echo
    pause
}

# ------------------------------
# Delete Key Vault
# ------------------------------
delete_vault() {

    header

    check_cli || return
    check_login || return

    read -rp "Key Vault Name : " VAULT

    echo
    read -rp "Delete this Key Vault? (Y/N): " CHOICE

    case $CHOICE in

        Y|y)

            az keyvault delete \
                --name "$VAULT"

            echo
            echo "Key Vault deleted."
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
# Create Secret
# ------------------------------
create_secret() {

    header

    check_cli || return
    check_login || return

    echo "Create Secret"
    echo "--------------------------------------------------"
    echo

    read -rp "Key Vault Name : " VAULT
    read -rp "Secret Name : " SECRET
    read -rp "Secret Value : " VALUE

    echo

    az keyvault secret set \
        --vault-name "$VAULT" \
        --name "$SECRET" \
        --value "$VALUE" \
        --output table

    echo
    pause
}

# ------------------------------
# List Secrets
# ------------------------------
list_secrets() {

    header

    check_cli || return
    check_login || return

    read -rp "Key Vault Name : " VAULT

    echo

    az keyvault secret list \
        --vault-name "$VAULT" \
        --output table

    echo
    pause
}

# ------------------------------
# Show Secret
# ------------------------------
show_secret() {

    header

    check_cli || return
    check_login || return

    read -rp "Key Vault Name : " VAULT
    read -rp "Secret Name : " SECRET

    echo

    az keyvault secret show \
        --vault-name "$VAULT" \
        --name "$SECRET" \
        --output table

    echo
    pause
}

# ------------------------------
# Delete Secret
# ------------------------------
delete_secret() {

    header

    check_cli || return
    check_login || return

    read -rp "Key Vault Name : " VAULT
    read -rp "Secret Name : " SECRET

    echo
    read -rp "Delete this secret? (Y/N): " CHOICE

    case $CHOICE in

        Y|y)

            az keyvault secret delete \
                --vault-name "$VAULT" \
                --name "$SECRET"

            echo
            echo "Secret deleted."
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
# List Keys
# ------------------------------
list_keys() {

    header

    check_cli || return
    check_login || return

    read -rp "Key Vault Name : " VAULT

    echo

    az keyvault key list \
        --vault-name "$VAULT" \
        --output table

    echo
    pause
}

# ------------------------------
# List Certificates
# ------------------------------
list_certificates() {

    header

    check_cli || return
    check_login || return

    read -rp "Key Vault Name : " VAULT

    echo

    az keyvault certificate list \
        --vault-name "$VAULT" \
        --output table

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

        echo "1. Create Key Vault"
        echo "2. List Key Vaults"
        echo "3. Show Key Vault"
        echo "4. Delete Key Vault"
        echo "5. Create Secret"
        echo "6. List Secrets"
        echo "7. Show Secret"
        echo "8. Delete Secret"
        echo "9. List Keys"
        echo "10. List Certificates"
        echo "11. Exit"
        echo

        read -rp "Enter your choice: " CHOICE

        case $CHOICE in

            1)
                create_vault
                ;;

            2)
                list_vaults
                ;;

            3)
                show_vault
                ;;

            4)
                delete_vault
                ;;

            5)
                create_secret
                ;;

            6)
                list_secrets
                ;;

            7)
                show_secret
                ;;

            8)
                delete_secret
                ;;

            9)
                list_keys
                ;;

            10)
                list_certificates
                ;;

            11)

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
