#!/bin/bash

USER_DB="users.db"
LOG_FILE="secure_log.txt"

SESSION_TIMEOUT=60
MAX_ATTEMPTS=3

MANAGER_NAME="Managed By: Yousub Ali"
YOUTUBE_LINK="https://youtube.com/@yourchannel"
TELEGRAM_LINK="https://t.me/yourchannel"

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
    echo -e "\e[36mYouTube: $YOUTUBE_LINK\e[0m"
    echo -e "\e[32mTelegram: $TELEGRAM_LINK\e[0m"
    echo "--------------------------------------"
}

# =============================
# HELP SYSTEM
# =============================

show_help() {
    banner
    echo -e "\e[1;36m📘 TOOL HELP INFORMATION\e[0m"
    echo "------------------------------------------------"
    echo "This tool is created for EDUCATIONAL PURPOSE ONLY."
    echo
    echo "It demonstrates:"
    echo "- Multi User Login System"
    echo "- Password Hashing (SHA256)"
    echo "- Session Timeout Protection"
    echo "- Brute Force Protection (Demo)"
    echo "- Theme Toggle Mode"
    echo
    echo "⚠️ This tool is NOT for hacking."
    echo "⚠️ Only use for learning Cyber Security basics."
    echo
    echo "📱 Join Telegram Channel:"
    echo "$TELEGRAM_LINK"
    echo
    echo "▶️ Subscribe YouTube Channel:"
    echo "$YOUTUBE_LINK"
    echo "------------------------------------------------"
    echo "Type 'open yt'  → Open YouTube"
    echo "Type 'open tg'  → Open Telegram"
    echo "Press Enter to return..."
    read
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
        sleep 1
        return
    fi

    read -s -p "Create Password: " password
    echo
    hash=$(echo -n "$password" | sha256sum | awk '{print $1}')
    echo "$username:$hash" >> $USER_DB
    log_event "New user registered: $username"
    echo "User Registered Successfully!"
    sleep 1
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
            sleep 1
            session "$username"
            return
        else
            attempts=$((attempts+1))
            echo "Invalid Credentials ($attempts/$MAX_ATTEMPTS)"
            sleep 1
        fi
    done

    log_event "Brute force protection triggered"
    echo "Account Locked (Demo Protection)"
    sleep 2
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
            sleep 2
            break
        fi

        banner
        echo "1. Toggle Theme"
        echo "2. Logout"
        echo "Type 'help' for tool information"
        echo "--------------------------------"
        read -p "Select Option: " choice

        case $choice in
            1)
                toggle_theme
                ;;
            2)
                log_event "Logout: $user"
                break
                ;;
            help|Help|HELP)
                show_help
                ;;
            open\ yt)
                xdg-open "$YOUTUBE_LINK" 2>/dev/null
                ;;
            open\ tg)
                xdg-open "$TELEGRAM_LINK" 2>/dev/null
                ;;
            *)
                echo "Invalid Command!"
                echo "Type 'help' to see available options."
                sleep 2
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
        echo "3. Help"
        echo "4. Exit"
        echo "--------------------------------"
        read -p "Select Option: " choice

        case $choice in
            1)
                register
                ;;
            2)
                login
                ;;
            3|help|Help)
                show_help
                ;;
            4)
                echo "System Shutdown"
                exit
                ;;
            *)
                echo "Invalid Command!"
                echo "Type 'help' to see tool information."
                sleep 2
                ;;
        esac
    done
}

# =============================
# Start
# =============================

main_menu
