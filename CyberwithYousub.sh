#!/bin/bash

USER_DB="users.db"
LOG_FILE="secure_log.txt"

SESSION_TIMEOUT=60
MAX_ATTEMPTS=3

MANAGER_NAME="Managed By: Yousub Ali"
YOUTUBE_LINK="https://youtube.com/@cyberwithyousub"
TELEGRAM_LINK="https://t.me/CyberWithYousub"

theme="dark"

# =============================
# Utility
# =============================

clear_screen() {
    clear
}

log_event() {
    echo "$(date) - $1" >> $LOG_FILE
}

banner() {
    clear_screen
    echo -e "\e[1;32m"
    figlet "CYBER FUTURE"
    echo -e "\e[0m"
    echo -e "\e[35m$MANAGER_NAME\e[0m"
    echo -e "\e[36mYouTube: $https://www.youtube.com/@cyberwithyousub\e[0m"
    echo -e "\e[32mTelegram: $https://t.me/CyberWithYousub\e[0m"
    echo "--------------------------------------"
}

# =============================
# User System
# =============================

init_db() {
    if [ ! -f "$USER_DB" ]; then
        touch "$USER_DB"
    fi
}

register() {
    init_db
    read -p "Create Username: " username

    if grep -q "^$username:" $USER_DB; then
        echo "User already exists!"
        return
    fi

    read -s -p "Create Password: " password
    echo
    hash=$(echo -n "$password" | sha256sum | awk '{print $1}')
    echo "$username:$hash" >> $USER_DB
    log_event "New user registered: $username"
    echo "User Registered Successfully!"
}

login() {
    init_db
    attempts=0

    while [ $attempts -lt $MAX_ATTEMPTS ]; do
        read -p "Username: " username
        read -s -p "Password: " password
        echo
        hash=$(echo -n "$password" | sha256sum | awk '{print $1}')

        stored=$(grep "^$username:" $USER_DB | cut -d ":" -f2)

        if [ "$hash" == "$stored" ] && [ ! -z "$stored" ]; then
            log_event "Login success: $username"
            echo "Login Successful!"
            session "$username"
            return
        else
            attempts=$((attempts+1))
            echo "Invalid Credentials ($attempts/$MAX_ATTEMPTS)"
        fi
    done

    log_event "Brute force protection triggered"
    echo "Account Locked (Demo Protection)"
}

# =============================
# Session
# =============================

session() {
    user=$1
    start_time=$(date +%s)

    while true; do
        current_time=$(date +%s)
        elapsed=$((current_time - start_time))

        if [ $elapsed -gt $SESSION_TIMEOUT ]; then
            echo "Session Timeout!"
            log_event "Session timeout: $user"
            break
        fi

        banner
        echo "1. Toggle Theme"
        echo "2. Open YouTube"
        echo "3. Open Telegram"
        echo "4. Logout"
        echo "--------------------------------"
        read -p "Select Option: " choice

        case $choice in
            1)
                toggle_theme
                ;;
            2)
                xdg-open "$YOUTUBE_LINK" 2>/dev/null
                ;;
            3)
                xdg-open "$TELEGRAM_LINK" 2>/dev/null
                ;;
            4)
                log_event "Logout: $user"
                break
                ;;
            *)
                echo "Invalid Option"
                sleep 1
                ;;
        esac
    done
}

toggle_theme() {
    if [ "$theme" == "dark" ]; then
        theme="light"
        echo "Light Mode Activated"
    else
        theme="dark"
        echo "Dark Mode Activated"
    fi
    sleep 1
}

# =============================
# Main Menu
# =============================

main_menu() {
    while true; do
        banner
        echo "1. Register"
        echo "2. Login"
        echo "3. Exit"
        echo "--------------------------------"
        read -p "Select Option: " choice

        case $choice in
            1)
                register
                ;;
            2)
                login
                ;;
            3)
                echo "System Shutdown"
                exit
                ;;
            *)
                echo "Invalid Option"
                sleep 1
                ;;
        esac
    done
}

# =============================
# Start
# =============================

main_menu