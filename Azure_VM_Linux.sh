#!/bin/bash

# ==========================================================
# Azure Script Engine
# Azure Virtual Machine Management (Linux)
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
    echo " Azure Virtual Machine Management"
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
        echo "You are not logged in."
        pause
        return 1
    fi

    return 0
}

# ------------------------------
# Create Virtual Machine
# ------------------------------
create_vm() {

    header

    check_cli || return
    check_login || return

    echo "Create Virtual Machine"
    echo "--------------------------------------------------"
    echo

    read -rp "Resource Group : " RG

    if [[ -z "$RG" ]]
    then
        echo
        echo "Resource Group cannot be empty."
        pause
        return
    fi

    read -rp "VM Name : " VM

    if [[ -z "$VM" ]]
    then
        echo
        echo "VM Name cannot be empty."
        pause
        return
    fi

    echo
    echo "Choose Image"
    echo
    echo "1. Ubuntu 24.04 LTS"
    echo "2. Ubuntu 22.04 LTS"
    echo "3. Windows Server 2022"
    echo

    read -rp "Choice : " IMAGE_CHOICE

    case $IMAGE_CHOICE in

        1)
            IMAGE="Ubuntu2404"
            ;;

        2)
            IMAGE="Ubuntu2204"
            ;;

        3)
            IMAGE="Win2022Datacenter"
            ;;

        *)
            echo
            echo "Invalid choice."
            pause
            return
            ;;
    esac

    echo
    echo "Common VM Sizes"
    echo
    echo "1. Standard_B1s"
    echo "2. Standard_B2s"
    echo "3. Standard_D2s_v5"
    echo

    read -rp "Choice : " SIZE_CHOICE

    case $SIZE_CHOICE in

        1)
            SIZE="Standard_B1s"
            ;;

        2)
            SIZE="Standard_B2s"
            ;;

        3)
            SIZE="Standard_D2s_v5"
            ;;

        *)
            echo
            echo "Invalid choice."
            pause
            return
            ;;
    esac

    echo

    read -rp "Admin Username : " USERNAME

    if [[ -z "$USERNAME" ]]
    then
        echo
        echo "Username cannot be empty."
        pause
        return
    fi

    echo
    echo "Authentication"
    echo
    echo "1. SSH Key"
    echo "2. Password"
    echo

    read -rp "Choice : " AUTH

    echo
    echo "Creating Virtual Machine..."
    echo

    if [[ "$AUTH" == "1" ]]
    then

        az vm create \
            --resource-group "$RG" \
            --name "$VM" \
            --image "$IMAGE" \
            --size "$SIZE" \
            --admin-username "$USERNAME" \
            --generate-ssh-keys \
            --output table

    elif [[ "$AUTH" == "2" ]]
    then

        read -rsp "Password : " PASSWORD
        echo

        az vm create \
            --resource-group "$RG" \
            --name "$VM" \
            --image "$IMAGE" \
            --size "$SIZE" \
            --admin-username "$USERNAME" \
            --admin-password "$PASSWORD" \
            --authentication-type password \
            --output table

    else

        echo
        echo "Invalid option."
        pause
        return

    fi

    echo

    if [ $? -eq 0 ]
    then
        echo "Virtual Machine created successfully."
    else
        echo "Failed to create Virtual Machine."
    fi

    echo
    pause
}

# ------------------------------
# List Virtual Machines
# ------------------------------
list_vm() {

    header

    check_cli || return
    check_login || return

    az vm list -d --output table

    echo
    pause
}

# ------------------------------
# Start Virtual Machine
# ------------------------------
start_vm() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "VM Name : " VM

    echo

    az vm start \
        --resource-group "$RG" \
        --name "$VM"

    echo
    echo "Start request submitted."

    echo
    pause
}

# ------------------------------
# Stop Virtual Machine
# ------------------------------
stop_vm() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "VM Name : " VM

    echo

    az vm stop \
        --resource-group "$RG" \
        --name "$VM"

    echo
    echo "Stop request submitted."

    echo
    pause
}

# ------------------------------
# Restart Virtual Machine
# ------------------------------
restart_vm() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "VM Name : " VM

    echo

    az vm restart \
        --resource-group "$RG" \
        --name "$VM"

    echo
    echo "Restart request submitted."

    echo
    pause
}

# ------------------------------
# Deallocate Virtual Machine
# ------------------------------
deallocate_vm() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "VM Name : " VM

    echo

    az vm deallocate \
        --resource-group "$RG" \
        --name "$VM"

    echo
    echo "Virtual Machine deallocated."

    echo
    pause
}

# ------------------------------
# Show Virtual Machine Details
# ------------------------------
show_vm() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "VM Name : " VM

    echo

    az vm show \
        --resource-group "$RG" \
        --name "$VM" \
        --show-details \
        --output table

    echo
    pause
}

# ------------------------------
# Delete Virtual Machine
# ------------------------------
delete_vm() {

    header

    check_cli || return
    check_login || return

    read -rp "Resource Group : " RG
    read -rp "VM Name : " VM

    echo
    echo "WARNING"
    echo "This will permanently delete the Virtual Machine."
    echo

    read -rp "Continue? (Y/N): " CHOICE

    case "$CHOICE" in

        Y|y)

            az vm delete \
                --resource-group "$RG" \
                --name "$VM" \
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
# List Available VM Sizes
# ------------------------------
list_sizes() {

    header

    check_cli || return
    check_login || return

    read -rp "Location : " LOCATION

    if [[ -z "$LOCATION" ]]
    then
        echo
        echo "Location cannot be empty."
        pause
        return
    fi

    echo

    az vm list-sizes \
        --location "$LOCATION" \
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

        echo "1. Create Virtual Machine"
        echo "2. List Virtual Machines"
        echo "3. Start Virtual Machine"
        echo "4. Stop Virtual Machine"
        echo "5. Restart Virtual Machine"
        echo "6. Deallocate Virtual Machine"
        echo "7. Show Virtual Machine Details"
        echo "8. Delete Virtual Machine"
        echo "9. List Available VM Sizes"
        echo "10. Exit"
        echo

        read -rp "Enter your choice: " CHOICE

        case $CHOICE in

            1)
                create_vm
                ;;

            2)
                list_vm
                ;;

            3)
                start_vm
                ;;

            4)
                stop_vm
                ;;

            5)
                restart_vm
                ;;

            6)
                deallocate_vm
                ;;

            7)
                show_vm
                ;;

            8)
                delete_vm
                ;;

            9)
                list_sizes
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
