#!/bin/bash

clear
echo "========================================="
echo "   Ubuntu VPS + Tailscale Auto Script    "
echo "========================================="
echo ""

# Ubuntu version selection (visual only)
echo "Select Ubuntu Version:"
echo "1) Ubuntu 20.04"
echo "2) Ubuntu 22.04"
echo "3) Ubuntu 24.04"
read -p "Enter your choice [1-3]: " CHOICE

case $CHOICE in
  1) UBUNTU_VER="20.04";;
  2) UBUNTU_VER="22.04";;
  3) UBUNTU_VER="24.04";;
  *) UBUNTU_VER="22.04";;
esac

echo "[+] Selected Ubuntu Version: $UBUNTU_VER"
sleep 1

# Generate username & password (20 chars)
USERNAME="vps$(tr -dc a-z0-9 </dev/urandom | head -c 5)"
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20)

# Generate hostname
HOSTNAME="github-vps-$(tr -dc a-z0-9 </dev/urandom | head -c 6)"

echo ""
echo "[+] Creating user..."
sudo useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME:$PASSWORD" | sudo chpasswd
sudo usermod -aG sudo "$USERNAME"

# Set hostname
echo "[+] Setting hostname..."
sudo hostnamectl set-hostname "$HOSTNAME"

# Install required packages
echo "[+] Installing packages..."
sudo apt update -y
sudo apt install -y curl openssh-server sudo

# Enable & start SSH
echo "[+] Starting SSH service..."
sudo systemctl enable ssh >/dev/null 2>&1
sudo systemctl restart ssh
sudo systemctl start ssh
# Install Tailscale
echo "[+] Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

# Ask for Tailscale Auth Key
echo ""
read -p "Enter your Tailscale Auth Key: " TSKEY

# Connect Tailscale with hostname
echo "[+] Connecting to Tailscale..."
sudo tailscale up --authkey "$TSKEY" --hostname "$HOSTNAME"

# Get Tailscale IP
TS_IP=$(tailscale ip -4 2>/dev/null)

# Display result
clear
echo "========================================="
echo "             VPS READY 🚀                "
echo "========================================="
echo ""
echo "Hostname     : $HOSTNAME"
echo "Ubuntu Ver   : $UBUNTU_VER"
echo "Username     : $USERNAME"
echo "Password     : $PASSWORD"
echo "Tailscale IP : $TS_IP"
echo ""
echo "SSH Login Command:"
echo "ssh $USERNAME@$TS_IP"
echo ""
echo "========================================="

# Keep running
echo "[*] VPS is running..."
echo "[*] Press CTRL+C to stop 🛑"

while true; do
    sleep 60
done
