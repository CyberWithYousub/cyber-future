# CYBER FUTURE - Secure Bash Login System

A simple secure Bash-based user authentication system with:

- User Registration & Login
- SHA256 Password Hashing
- Brute Force Protection (Max Attempts)
- Session Timeout System
- Activity Logging
- Dark/Light Theme Toggle
- YouTube & Telegram Quick Access

Managed By: Yousub Ali  
YouTube: https://youtube.com/@cyberwithyousub  
Telegram: https://t.me/CyberWithYousub  

---

## 📌 Features

✔ Secure password hashing (SHA256)  
✔ Login attempt limit protection  
✔ Session timeout security  
✔ Log file generation  
✔ Clean terminal UI  
✔ Works in Linux & Termux  

---

## 📂 Project Structure

```
bash.sh
README.md
```

When running:
- users.db → stores user credentials (auto created)
- secure_log.txt → stores activity logs (auto created)

---

## ⚙️ Requirements

- Linux / Ubuntu / Kali Linux
- OR Termux (Android)
- figlet installed
- coreutils (sha256sum support)

---

## 🛠 Installation (Linux / Kali)

```bash
sudo apt update
sudo apt install figlet -y
```

---

## 📱 Installation (Termux)

```bash
pkg update
pkg install figlet -y
pkg install coreutils -y
```

---

## 🚀 How To Use

### 1️⃣ Clone Repository

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
```

### 2️⃣ Go Inside Folder

```bash
cd YOUR_REPOSITORY
```

### 3️⃣ Give Permission

```bash
chmod +x CyberwithYousub.sh
```

### 4️⃣ Run Tool

```bash
./CyberwithYousub.sh
```

OR

```bash
bash bash.sh
```

---

## 🔐 Security System Explained

### Password Security
Passwords are encrypted using SHA256 before storing in users.db.

### Brute Force Protection
- Maximum 3 login attempts
- After 3 failed attempts → Account Locked (Demo Mode)

### Session Timeout
- Session expires after 60 seconds of inactivity.

### Logging System
All actions are stored in:
```
secure_log.txt
```

---

## 🧠 How It Works

1. User registers → Username & hashed password stored
2. User logs in → Hash verified
3. Session starts → Timeout counter active
4. Actions logged in secure_log.txt

---

## ⚠️ Disclaimer

This tool is for Educational Purpose Only.  
Do not use for illegal activities.

---

## 👨‍💻 Author

Yousub Ali  
Cyber Security Enthusiast