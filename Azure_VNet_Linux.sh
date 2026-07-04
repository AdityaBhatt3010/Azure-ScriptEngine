#!/bin/bash

# ==========================================================
# Azure Script Engine
# Azure Virtual Network Management (Linux)
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
    echo " Azure Virtual Network Management"
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
# Create Virtual Network
# ------------------------------
create_vnet() {

    header

    check_cli || return
    check_login || return

    echo "Create Virtual Network"
    echo "--------------------------------------------------"
    echo

    read -rp "Resource Group : " RG
    read -rp "Virtual Network Name : " VNET
    read -rp "Location : " LOCATION
    read -rp "Address Space (Example 10.0.0.0/16) : " ADDRESS

    echo

    az network vnet create \
        --resource-group "$RG" \
        --name "$VNET" \
        --location "$LOCATION" \
        --address-prefixes "$ADDRESS" \
        --output table

    echo
    pause
}

# ------------------------------
# List Virtual Networks
# ------------------------------
list_vnets() {

    header

    check_cli || return
    check_login || return

    az network vnet list --output table

    echo
    pause
}

# ------------------------------
# Show Virtual Network
# ------------------------------
show_vnet() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "Virtual Network : " VNET

    echo

    az network vnet show \
        --resource-group "$RG" \
        --name "$VNET" \
        --output table

    echo
    pause
}

# ------------------------------
# Delete Virtual Network
# ------------------------------
delete_vnet() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "Virtual Network : " VNET

    echo
    read -rp "Delete this VNet? (Y/N): " CHOICE

    case $CHOICE in

        Y|y)

            az network vnet delete \
                --resource-group "$RG" \
                --name "$VNET"

            echo
            echo "Virtual Network deleted."
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
# Create Subnet
# ------------------------------
create_subnet() {

    header

    check_cli || return
    check_login || return

    echo "Create Subnet"
    echo "--------------------------------------------------"
    echo

    read -rp "Resource Group : " RG
    read -rp "Virtual Network : " VNET
    read -rp "Subnet Name : " SUBNET
    read -rp "Address Prefix (Example 10.0.1.0/24) : " PREFIX

    echo

    az network vnet subnet create \
        --resource-group "$RG" \
        --vnet-name "$VNET" \
        --name "$SUBNET" \
        --address-prefixes "$PREFIX" \
        --output table

    echo
    pause
}

# ------------------------------
# List Subnets
# ------------------------------
list_subnets() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "Virtual Network : " VNET

    echo

    az network vnet subnet list \
        --resource-group "$RG" \
        --vnet-name "$VNET" \
        --output table

    echo
    pause
}

# ------------------------------
# Show Subnet
# ------------------------------
show_subnet() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "Virtual Network : " VNET
    read -rp "Subnet Name : " SUBNET

    echo

    az network vnet subnet show \
        --resource-group "$RG" \
        --vnet-name "$VNET" \
        --name "$SUBNET" \
        --output table

    echo
    pause
}

# ------------------------------
# Delete Subnet
# ------------------------------
delete_subnet() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "Virtual Network : " VNET
    read -rp "Subnet Name : " SUBNET

    echo
    read -rp "Delete this subnet? (Y/N): " CHOICE

    case $CHOICE in

        Y|y)

            az network vnet subnet delete \
                --resource-group "$RG" \
                --vnet-name "$VNET" \
                --name "$SUBNET"

            echo
            echo "Subnet deleted."
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
# Create VNet Peering
# ------------------------------
create_peering() {

    header

    check_cli || return
    check_login || return

    echo "Create VNet Peering"
    echo "--------------------------------------------------"
    echo

    read -rp "Resource Group : " RG
    read -rp "Source VNet : " SOURCE
    read -rp "Peering Name : " PEERING
    read -rp "Target VNet Resource ID : " TARGET

    echo

    az network vnet peering create \
        --resource-group "$RG" \
        --vnet-name "$SOURCE" \
        --name "$PEERING" \
        --remote-vnet "$TARGET" \
        --allow-vnet-access \
        --output table

    echo
    pause
}

# ------------------------------
# List VNet Peerings
# ------------------------------
list_peerings() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "Virtual Network : " VNET

    echo

    az network vnet peering list \
        --resource-group "$RG" \
        --vnet-name "$VNET" \
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

        echo "1. Create Virtual Network"
        echo "2. List Virtual Networks"
        echo "3. Show Virtual Network"
        echo "4. Delete Virtual Network"
        echo "5. Create Subnet"
        echo "6. List Subnets"
        echo "7. Show Subnet"
        echo "8. Delete Subnet"
        echo "9. Create VNet Peering"
        echo "10. List VNet Peerings"
        echo "11. Exit"
        echo

        read -rp "Enter your choice: " CHOICE

        case $CHOICE in

            1)
                create_vnet
                ;;

            2)
                list_vnets
                ;;

            3)
                show_vnet
                ;;

            4)
                delete_vnet
                ;;

            5)
                create_subnet
                ;;

            6)
                list_subnets
                ;;

            7)
                show_subnet
                ;;

            8)
                delete_subnet
                ;;

            9)
                create_peering
                ;;

            10)
                list_peerings
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
