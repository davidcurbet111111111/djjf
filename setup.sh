#!/bin/bash

# 1. Выбор версии Ubuntu
echo "------------------------------------------"
echo "Select Ubuntu OS version for VPS:"
echo "1) Ubuntu 20.04 LTS"
echo "2) Ubuntu 22.04 LTS"
echo "3) Ubuntu 24.04 LTS"
read -p "Enter your choice (1-3): " os_version

case $os_version in
    1) OS="Ubuntu 20.04" ;;
    2) OS="Ubuntu 22.04" ;;
    3) OS="Ubuntu 24.04" ;;
    *) OS="Ubuntu (Default)" ;;
esac

# 2. Ввод ключа Tailscale
echo "------------------------------------------"
read -p "Enter your Tailscale Auth Key: " TS_KEY

# 3. Генерация пользователя и пароля (20 символов)
USER="vpsuser"
PASS=$(openssl rand -base64 15 | tr -dc 'a-zA-Z0-9' | head -c 20)
HOSTNAME="github-vps"

echo "Configuring $OS environment..."

# 4. Создание пользователя и настройка системы
sudo useradd -m -s /bin/bash $USER
echo "$USER:$PASS" | sudo chpasswd
sudo usermod -aG sudo $USER

# 5. Установка и запуск SSH
sudo apt-get update && sudo apt-get install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh

# 6. Установка Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# 7. Запуск Tailscale с указанным Hostname
sudo tailscale up --authkey=$TS_KEY --hostname=$HOSTNAME --ssh

# 8. Получение IP и вывод данных
TS_IP=$(tailscale ip -4)

clear
echo "=========================================="
echo "    UBUNTU VPS IS READY (Tailscale)     "
echo "=========================================="
echo "OS Version:   $OS"
echo "Hostname:     $HOSTNAME"
echo "Tailscale IP: $TS_IP"
echo "Username:     $USER"
echo "Password:     $PASS"
echo "=========================================="
echo "SSH Service:  Started"
echo "Status:       Running..."
echo "Press CTRL+C to stop and exit."
echo "=========================================="

# Остановка процесса по Ctrl+C
trap "echo 'Stopping VPS...'; exit" SIGINT
sleep 100000
