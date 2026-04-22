#!/bin/bash

clear
echo "======================================"
echo "   Ubuntu VPS + Tailscale Generator   "
echo "======================================"
echo ""

# Ubuntu version selection (visual only)
echo "Select Ubuntu Version:"
echo "1) Ubuntu 20.04"
echo "2) Ubuntu 22.04"
echo "3) Ubuntu 24.04"
read -p "Enter your choice [1-3]: " UBUNTU_VER

case $UBUNTU_VER in
  1) VERSION="20.04";;
  2) VERSION="22.04";;
  3) VERSION="24.04";;
  *) VERSION="22.04";;
esac

echo "[+] Selected Ubuntu Version: $VERSION"
sleep 1

# Generate username + password
USERNAME="vps$(tr -dc a-z0-9 </dev/urandom | head -c 5)"
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20)

# Generate hostname
HOSTNAME="github-vps-$(tr -dc a-z0-9 </dev/urandom | head -c 6)"

echo ""
echo "[+] Creating VPS user..."
sudo useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME:$PASSWORD" | sudo chpasswd
sudo usermod -aG sudo "$USERNAME"

# Set hostname
echo "[+] Setting hostname..."
sudo hostnamectl set-hostname "$HOSTNAME"

# Install packages
echo "[+] Installing required packages..."
sudo apt update -y
sudo apt install -y curl openssh-server

# Start SSH
echo "[+] Starting SSH service..."
sudo systemctl enable ssh
sudo systemctl restart ssh
sudo systemctl start ssh

# Install Tailscale
echo "[+] Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

# Ask for auth key
echo ""
read -p "Enter your Tailscale Auth Key: " TSKEY

# Connect Tailscale
echo "[+] Connecting to Tailscale..."
sudo tailscale up --authkey "$TSKEY"

# Get Tailscale IP
TS_IP=$(tailscale ip -4 2>/dev/null)

# Output details
clear
echo "======================================"
echo "            VPS READY 🚀              "
echo "======================================"
echo ""
echo "Hostname     : $HOSTNAME"
echo "Ubuntu Ver   : $VERSION"
echo "Username     : $USERNAME"
echo "Password     : $PASSWORD"
echo "Tailscale IP : $TS_IP"
echo ""
echo "SSH Login Command:"
echo "ssh $USERNAME@$TS_IP"
echo ""
echo "======================================"

# Keep running
echo "[*] VPS is running..."
echo "[*] Press CTRL+C to stop 🛑"

while true; do
    sleep 60
done
