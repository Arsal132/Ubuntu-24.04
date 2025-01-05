#!/bin/bash

# Update package repositories
apt update && apt upgrade -y

# Install essential packages
apt install -y wget curl git sudo nano

# Install X11 packages and desktop environment
apt install -y \
    xfce4 \
    xfce4-terminal \
    dbus-x11 \
    tigervnc-standalone-server \
    tigervnc-common

# Install Yaru themes
apt install -y \
    yaru-theme-gtk \
    yaru-theme-icon \
    gnome-themes-extra \
    gtk2-engines-murrine

# Create VNC startup script
cat > ~/.vnc/xstartup << 'EOF'
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
EOF

# Make xstartup executable
chmod +x ~/.vnc/xstartup

# Create VNC config
cat > ~/.vnc/config << 'EOF'
geometry=1280x720
depth=24
EOF

# Start VNC server function
start_vnc() {
    vncserver -kill :1 2>/dev/null || true
    vncserver :1
}

# Apply Yaru theme settings
cat > ~/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xsettings" version="1.0">
  <property name="Net" type="empty">
    <property name="ThemeName" type="string" value="Yaru"/>
    <property name="IconThemeName" type="string" value="Yaru"/>
  </property>
</channel>
EOF

# Create desktop launcher
cat > ~/Desktop/tipsandtricks.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Tips and Tricks
Comment=Launch Tips and Tricks
Exec=xdg-open https://github.com/yourusername/tipsandtricks
Icon=system-help
Terminal=false
Categories=Utility;
EOF

# Make desktop launcher executable
chmod +x ~/Desktop/tipsandtricks.desktop

# Generate GitHub repository
echo "# Tips and Tricks for Ubuntu 24.04 PRoot Setup" > README.md
echo "## Installation Instructions" >> README.md
echo "1. Install proot-distro" >> README.md
echo "2. Install Ubuntu 24.04" >> README.md
echo "3. Setup Desktop Environment" >> README.md
echo "4. Install Yaru Themes" >> README.md

# Initialize git repository
git init
git add README.md
git commit -m "Initial commit"

# Print instructions
echo "Installation completed!"
echo "To start VNC server, run: start_vnc"
echo "Connect using VNC viewer at localhost:5901"
