#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Glava-Config-Gui Installer           ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""

# Detect Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VER=$VERSION_ID
else
    echo -e "${RED}Cannot detect Linux distribution${NC}"
    exit 1
fi

echo -e "${YELLOW}Detected: $PRETTY_NAME${NC}"
echo ""

# Function to check if running as root
check_sudo() {
    if [ "$EUID" -ne 0 ] && ! sudo -n true 2>/dev/null; then
        echo -e "${RED}This script requires sudo privileges. Please enter your password:${NC}"
        sudo -v
    fi
}

# Install dependencies based on distro
install_dependencies() {
    case "$OS" in
        # Debian/Ubuntu/Mint/PopOS
        debian|ubuntu|linuxmint|pop-os)
            echo -e "${YELLOW}Installing dependencies for Debian/Ubuntu...${NC}"
            check_sudo
            sudo apt update
            sudo apt install -y python3 python3-gi libgtk-4-0 libadwaita-1-0 psmisc glava
            ;;
        
        # Arch/Manjaro
        arch|manjaro|arcolinux)
            echo -e "${YELLOW}Installing dependencies for Arch/Manjaro...${NC}"
            check_sudo
            sudo pacman -Sy --noconfirm python python-gobject gtk4 libadwaita psmisc glava
            ;;
        
        # Fedora/RHEL/CentOS
        fedora|rhel|centos)
            echo -e "${YELLOW}Installing dependencies for Fedora/RHEL...${NC}"
            check_sudo
            sudo dnf install -y python3 python3-gobject gtk4-devel libadwaita-devel psmisc glava
            ;;
        
        # openSUSE
        opensuse|opensuse-leap|opensuse-tumbleweed)
            echo -e "${YELLOW}Installing dependencies for openSUSE...${NC}"
            check_sudo
            sudo zypper install -y python3 python3-gobject-Gdk libgtk-4-0 libadwaita-devel psmisc glava
            ;;
        
        *)
            echo -e "${RED}Unsupported distribution: $OS${NC}"
            echo "Supported: Debian, Ubuntu, Arch, Manjaro, Fedora, openSUSE"
            exit 1
            ;;
    esac
}

# Download and install glava-config-gui
install_glava_config_gui() {
    echo ""
    echo -e "${YELLOW}Downloading glava-config-gui...${NC}"
    
    REPO_URL="https://raw.githubusercontent.com/BlackoneBc/Glava-Config-Gui/main"
    INSTALL_DIR="/usr/local/bin"
    SCRIPT_FILE="glava-config-gui"
    
    check_sudo
    
    # Download the script
    sudo curl -sSL "${REPO_URL}/${SCRIPT_FILE}" -o "/tmp/${SCRIPT_FILE}"
    
    # Move to bin and make executable
    sudo mv "/tmp/${SCRIPT_FILE}" "${INSTALL_DIR}/${SCRIPT_FILE}"
    sudo chmod +x "${INSTALL_DIR}/${SCRIPT_FILE}"
    
    echo -e "${GREEN}✓ Installed to ${INSTALL_DIR}/${SCRIPT_FILE}${NC}"
}

# Create desktop entry for applications menu
create_desktop_entry() {
    echo -e "${YELLOW}Creating desktop entry...${NC}"
    
    DESKTOP_FILE="/usr/share/applications/glava-config-gui.desktop"
    ICON_URL="https://raw.githubusercontent.com/BlackoneBc/Glava-Config-Gui/main/glava-config-gui.png"
    ICON_PATH="/usr/share/pixmaps/glava-config-gui.png"
    
    check_sudo
    
    # Download icon if exists
    if curl -sSL --head "${ICON_URL}" | grep -q "200 OK"; then
        sudo curl -sSL "${ICON_URL}" -o "/tmp/glava-config-gui.png"
        sudo mv "/tmp/glava-config-gui.png" "${ICON_PATH}"
        ICON_LINE="Icon=glava-config-gui"
    else
        ICON_LINE="Icon=audacious"  # Fallback to generic audio icon
    fi
    
    # Create desktop entry
    sudo tee "${DESKTOP_FILE}" > /dev/null << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Glava Config GUI
Comment=Configure the glava audio visualizer
Exec=glava-config-gui
${ICON_LINE}
Categories=Audio;Utility;
Terminal=false
StartupNotify=true
EOF
    
    # Update desktop database
    sudo update-desktop-database /usr/share/applications/ 2>/dev/null || true
    
    echo -e "${GREEN}✓ Desktop entry created${NC}"
}

# Main installation flow
main() {
    install_dependencies
    install_glava_config_gui
    create_desktop_entry
    
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   Installation Complete!               ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}You can now launch glava-config-gui with:${NC}"
    echo -e "${GREEN}  glava-config-gui${NC}"
    echo ""
    echo -e "${YELLOW}To uninstall, use your package manager:${NC}"
    echo -e "${GREEN}  Debian/Ubuntu:${NC}  sudo apt remove glava-config-gui"
    echo -e "${GREEN}  Arch/Manjaro:${NC}   pacman -R glava-config-gui"
    echo -e "${GREEN}  Fedora:${NC}         sudo dnf remove glava-config-gui"
    echo ""
}

main
