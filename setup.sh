#!/bin/bash
# Ubuntu 24.04 on Termux with Yaru Theme - Single Command Installer

# Update Termux and Install Dependencies
echo "Updating Termux and installing dependencies..."
pkg update -y && pkg upgrade -y
pkg install -y proot-distro git

# Install Ubuntu 24.04
echo "Installing Ubuntu 24.04..."
proot-distro install ubuntu-24.04

# Add alias for Ubuntu login
if ! grep -q "alias ubuntu=" ~/.bashrc; then
    echo "alias ubuntu='proot-distro login ubuntu-24.04'" >> ~/.bashrc
    source ~/.bashrc
fi

# Update Ubuntu and Install Yaru Theme
echo "Configuring Ubuntu and installing Yaru theme..."
proot-distro login ubuntu-24.04 -- bash -c "
    apt update && apt upgrade -y
    apt install -y git gtk2-engines-murrine gtk3-engines-unico gnome-themes-standard
    git clone https://github.com/ubuntu/yaru.git
    cd yaru
    ./install.sh
"

echo "Installation complete! Type 'ubuntu' to start Ubuntu 24.04 with Yaru theme."
