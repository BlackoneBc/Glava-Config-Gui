#!/bin/bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Glava-Config-Gui Installer           ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo -e "${RED}Cannot detect Linux distribution${NC}"
    exit 1
fi

echo -e "${YELLOW}Detected: $PRETTY_NAME${NC}"
echo ""

check_sudo() {
    if [ "$EUID" -ne 0 ] && ! sudo -n true 2>/dev/null; then
        sudo -v
    fi
}

install_yay() {
    if command -v yay &> /dev/null; then return 0; fi
    echo -e "${YELLOW}Installing yay...${NC}"
    check_sudo
    sudo pacman -Sy --noconfirm base-devel git
    local tmp=$(mktemp -d)
    cd "$tmp"
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si --noconfirm
    cd / && rm -rf "$tmp"
}

check_aur_helper() {
    command -v yay &>/dev/null && echo "yay" && return
    command -v paru &>/dev/null && echo "paru" && return
    echo ""
}

install_dependencies() {
    case "$OS" in
        debian|ubuntu|linuxmint|pop-os)
            check_sudo
            sudo apt update
            sudo apt install -y python3 python3-gi libgtk-4-0 libadwaita-1-0 psmisc glava
            ;;
        arch|manjaro|arcolinux)
            check_sudo
            sudo pacman -Sy --noconfirm python python-gobject gtk4 libadwaita psmisc
            local aur=$(check_aur_helper)
            if [ -z "$aur" ]; then install_yay; aur="yay"; fi
            $aur -S --noconfirm glava
            ;;
        fedora|rhel|centos)
            check_sudo
            sudo dnf install -y python3 python3-gobject gtk4-devel libadwaita-devel psmisc glava
            ;;
        opensuse*)
            check_sudo
            sudo zypper install -y python3 python3-gobject libgtk-4-0 libadwaita-devel psmisc glava
            ;;
        *)
            echo -e "${RED}Unsupported distribution: $OS${NC}"
            exit 1
            ;;
    esac
}

install_script() {
    echo -e "${YELLOW}Downloading glava-config-gui...${NC}"
    check_sudo
    sudo curl -sSL "https://raw.githubusercontent.com/BlackoneBc/Glava-Config-Gui/main/glava-config-gui" \
        -o "/usr/bin/glava-config-gui"
    sudo chmod +x "/usr/bin/glava-config-gui"
    echo -e "${GREEN}✓ Script installed${NC}"
}

create_desktop_entry() {
    echo -e "${YELLOW}Creating desktop entry...${NC}"
    check_sudo
    sudo tee /usr/share/applications/glava-config-gui.desktop > /dev/null << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Glava Config GUI
Comment=Configure the glava audio visualizer
Exec=glava-config-gui
Icon=preferences-system
Categories=Audio;Utility;
Terminal=false
StartupNotify=true
EOF
    sudo update-desktop-database /usr/share/applications/ 2>/dev/null || true
    echo -e "${GREEN}✓ Desktop entry created${NC}"
}

register_pacman_package() {
    if ! command -v pacman &>/dev/null; then return 0; fi

    echo -e "${YELLOW}Registering package with pacman...${NC}"

    local tmpdir=$(mktemp -d)
    cd "$tmpdir"

    # PKGBUILD schreiben – makepkg baut das Paket korrekt
    cat > "$tmpdir/PKGBUILD" << 'EOF'
pkgname=glava-config-gui
pkgver=1.0.0
pkgrel=1
pkgdesc="GTK4/Libadwaita GUI to configure the glava audio visualizer"
arch=('any')
url="https://github.com/BlackoneBc/Glava-Config-Gui"
license=('MIT')
depends=('python' 'python-gobject' 'gtk4' 'libadwaita' 'psmisc' 'glava')

package() {
    install -Dm755 /usr/bin/glava-config-gui \
        "$pkgdir/usr/bin/glava-config-gui"
    install -Dm644 /usr/share/applications/glava-config-gui.desktop \
        "$pkgdir/usr/share/applications/glava-config-gui.desktop"
    install -Dm644 /dev/stdin \
        "$pkgdir/usr/share/licenses/glava-config-gui/LICENSE" << 'LICENSE'
MIT License - BlackoneBc - https://github.com/BlackoneBc/Glava-Config-Gui
LICENSE
}
EOF

    # makepkg als normaler User ausführen (darf nicht root sein)
    if [ "$EUID" -eq 0 ]; then
        # Als root: temporären User nutzen oder direkt ins DB eintragen
        echo -e "${YELLOW}Skipping pacman registration (running as root)${NC}"
        rm -rf "$tmpdir"
        return 0
    fi

    cd "$tmpdir"
    makepkg -sf --noconfirm 2>/dev/null

    local pkgfile
    pkgfile=$(ls "$tmpdir"/*.pkg.tar.* 2>/dev/null | head -1)

    if [ -z "$pkgfile" ]; then
        echo -e "${RED}Package build failed, skipping registration${NC}"
        rm -rf "$tmpdir"
        return 0
    fi

    check_sudo
    sudo pacman -U --noconfirm "$pkgfile"

    rm -rf "$tmpdir"
    echo -e "${GREEN}✓ Package registered with pacman${NC}"
}

main() {
    install_dependencies
    install_script
    create_desktop_entry
    register_pacman_package

    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   Installation Complete!               ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "Launch: ${GREEN}glava-config-gui${NC}"
    echo -e "Remove: ${GREEN}sudo pacman -R glava-config-gui${NC}"
    echo ""
}

main
