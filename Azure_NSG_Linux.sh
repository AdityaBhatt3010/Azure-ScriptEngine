#!/bin/bash

# ==========================================================
# Azure Script Engine
# Azure Network Security Group Management (Linux)
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
    echo " Azure Network Security Group Management"
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
# Create NSG
# ------------------------------
create_nsg() {

    header

    check_cli || return
    check_login || return

    echo "Create Network Security Group"
    echo "--------------------------------------------------"
    echo

    read -rp "Resource Group : " RG
    read -rp "NSG Name : " NSG
    read -rp "Location : " LOCATION

    echo

    az network nsg create \
        --resource-group "$RG" \
        --name "$NSG" \
        --location "$LOCATION" \
        --output table

    echo
    pause
}

# ------------------------------
# List NSGs
# ------------------------------
list_nsg() {

    header

    check_cli || return
    check_login || return

    az network nsg list --output table

    echo
    pause
}

# ------------------------------
# Show NSG Details
# ------------------------------
show_nsg() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "NSG Name : " NSG

    echo

    az network nsg show \
        --resource-group "$RG" \
        --name "$NSG" \
        --output table

    echo
    pause
}

# ------------------------------
# Delete NSG
# ------------------------------
delete_nsg() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "NSG Name : " NSG

    echo
    read -rp "Delete this NSG? (Y/N): " CHOICE

    case $CHOICE in

        Y|y)

            az network nsg delete \
                --resource-group "$RG" \
                --name "$NSG"

            echo
            echo "NSG deleted."
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
# Create Security Rule
# ------------------------------
create_rule() {

    header

    check_cli || return
    check_login || return

    echo "Create Security Rule"
    echo "--------------------------------------------------"
    echo

    read -rp "Resource Group : " RG
    read -rp "NSG Name : " NSG
    read -rp "Rule Name : " RULE

    read -rp "Priority (100-4096) : " PRIORITY

    echo
    echo "Direction"
    echo "1. Inbound"
    echo "2. Outbound"

    read -rp "Choice : " DIR

    case $DIR in

        1)
            DIRECTION="Inbound"
            ;;

        2)
            DIRECTION="Outbound"
            ;;

        *)
            echo
            echo "Invalid option."
            pause
            return
            ;;
    esac

    echo
    echo "Access"
    echo "1. Allow"
    echo "2. Deny"

    read -rp "Choice : " ACC

    case $ACC in

        1)
            ACCESS="Allow"
            ;;

        2)
            ACCESS="Deny"
            ;;

        *)
            echo
            echo "Invalid option."
            pause
            return
            ;;
    esac

    read -rp "Protocol (Tcp/Udp/*) : " PROTOCOL
    read -rp "Destination Port : " PORT

    echo

    az network nsg rule create \
        --resource-group "$RG" \
        --nsg-name "$NSG" \
        --name "$RULE" \
        --priority "$PRIORITY" \
        --direction "$DIRECTION" \
        --access "$ACCESS" \
        --protocol "$PROTOCOL" \
        --destination-port-ranges "$PORT" \
        --output table

    echo
    pause
}

# ------------------------------
# List Security Rules
# ------------------------------
list_rules() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "NSG Name : " NSG

    echo

    az network nsg rule list \
        --resource-group "$RG" \
        --nsg-name "$NSG" \
        --output table

    echo
    pause
}

# ------------------------------
# Delete Security Rule
# ------------------------------
delete_rule() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "NSG Name : " NSG
    read -rp "Rule Name : " RULE

    echo
    read -rp "Delete this rule? (Y/N): " CHOICE

    case $CHOICE in

        Y|y)

            az network nsg rule delete \
                --resource-group "$RG" \
                --nsg-name "$NSG" \
                --name "$RULE"

            echo
            echo "Security Rule deleted."
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
# Associate NSG to Subnet
# ------------------------------
associate_subnet() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "Virtual Network : " VNET
    read -rp "Subnet Name : " SUBNET
    read -rp "NSG Name : " NSG

    echo

    az network vnet subnet update \
        --resource-group "$RG" \
        --vnet-name "$VNET" \
        --name "$SUBNET" \
        --network-security-group "$NSG" \
        --output table

    echo
    pause
}

# ------------------------------
# Associate NSG to NIC
# ------------------------------
associate_nic() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "NIC Name : " NIC
    read -rp "NSG Name : " NSG

    echo

    az network nic update \
        --resource-group "$RG" \
        --name "$NIC" \
        --network-security-group "$NSG" \
        --output table

    echo
    pause
}

# ------------------------------
# Remove NSG Association
# ------------------------------
remove_association() {

    header

    check_cli || return
    check_login || return

    echo "Remove NSG Association"
    echo
    echo "1. From Subnet"
    echo "2. From Network Interface"
    echo

    read -rp "Choice : " TYPE

    case $TYPE in

        1)

            read -rp "Resource Group : " RG
            read -rp "Virtual Network : " VNET
            read -rp "Subnet Name : " SUBNET

            az network vnet subnet update \
                --resource-group "$RG" \
                --vnet-name "$VNET" \
                --name "$SUBNET" \
                --remove networkSecurityGroup

            ;;

        2)

            read -rp "Resource Group : " RG
            read -rp "NIC Name : " NIC

            az network nic update \
                --resource-group "$RG" \
                --name "$NIC" \
                --remove networkSecurityGroup

            ;;

        *)

            echo
            echo "Invalid option."
            pause
            return
            ;;
    esac

    echo
    echo "Association removed."

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

        echo "1. Create NSG"
        echo "2. List NSGs"
        echo "3. Show NSG"
        echo "4. Delete NSG"
        echo "5. Create Security Rule"
        echo "6. List Security Rules"
        echo "7. Delete Security Rule"
        echo "8. Associate NSG to Subnet"
        echo "9. Associate NSG to NIC"
        echo "10. Remove NSG Association"
        echo "11. Exit"
        echo

        read -rp "Enter your choice: " CHOICE

        case $CHOICE in

            1)
                create_nsg
                ;;

            2)
                list_nsg
                ;;

            3)
                show_nsg
                ;;

            4)
                delete_nsg
                ;;

            5)
                create_rule
                ;;

            6)
                list_rules
                ;;

            7)
                delete_rule
                ;;

            8)
                associate_subnet
                ;;

            9)
                associate_nic
                ;;

            10)
                remove_association
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
