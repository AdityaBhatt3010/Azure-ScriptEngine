#!/bin/bash

# ==========================================================
# Azure Script Engine
# Azure CLI Setup & Account Management (Linux)
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
    echo " Azure CLI Setup & Account Management"
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
        echo
        echo "Select option 1 to install Azure CLI."
        pause
        return 1
    fi

    return 0
}

# ------------------------------
# Install Azure CLI
# ------------------------------
install_cli() {

    header

    if command -v az >/dev/null 2>&1
    then
        echo "Azure CLI is already installed."
        echo
        az version
        echo
        pause
        return
    fi

    echo "Installing Azure CLI..."
    echo

    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

    echo

    if command -v az >/dev/null 2>&1
    then
        echo "Azure CLI installed successfully."
    else
        echo "Installation failed."
    fi

    echo
    pause
}

# ------------------------------
# Login
# ------------------------------
login() {

    header

    check_cli || return

    echo "Opening Azure Login..."
    echo

    az login

    echo
    pause
}

# ------------------------------
# Logout
# ------------------------------
logout() {

    header

    check_cli || return

    az logout

    echo
    echo "Logged out successfully."
    echo

    pause
}

# ------------------------------
# Azure CLI Version
# ------------------------------
version() {

    header

    check_cli || return

    az version

    echo
    pause
}

# ------------------------------
# Show Current Account
# ------------------------------
show_account() {

    header

    check_cli || return

    az account show --output table

    echo
    pause
}

# ------------------------------
# List Subscriptions
# ------------------------------
list_subscriptions() {

    header

    check_cli || return

    az account list --output table

    echo
    pause
}

# ------------------------------
# Switch Subscription
# ------------------------------
switch_subscription() {

    header

    check_cli || return

    echo "Available Subscriptions"
    echo

    az account list --output table

    echo
    read -rp "Enter Subscription ID or Name: " SUB

    if [[ -z "$SUB" ]]
    then
        echo
        echo "Subscription cannot be empty."
        pause
        return
    fi

    az account set --subscription "$SUB"

    if [ $? -eq 0 ]
    then
        echo
        echo "Subscription changed successfully."
        echo
        az account show --output table
    else
        echo
        echo "Unable to change subscription."
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

        echo "1. Install Azure CLI"
        echo "2. Login to Azure"
        echo "3. Show Current Account"
        echo "4. List Subscriptions"
        echo "5. Switch Subscription"
        echo "6. Check Azure CLI Version"
        echo "7. Logout"
        echo "8. Exit"
        echo

        read -rp "Enter your choice: " choice

        case $choice in

            1)
                install_cli
                ;;

            2)
                login
                ;;

            3)
                show_account
                ;;

            4)
                list_subscriptions
                ;;

            5)
                switch_subscription
                ;;

            6)
                version
                ;;

            7)
                logout
                ;;

            8)
                clear
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
