# Glava-Config-Gui Installer Generator
# This script creates distribution-specific packages

#!/bin/bash

# Create Debian package structure
create_debian_package() {
    mkdir -p debian
    
    cat > debian/control << 'EOF'
Package: glava-config-gui
Version: 1.0.0
Section: sound
Priority: optional
Architecture: all
Depends: python3, python3-gi, libgtk-4-0, libadwaita-1-0, psmisc, glava
Maintainer: BlackoneBc <jlm2@freenet.de>
Description: GTK4 GUI to configure the glava audio visualizer
 Glava-Config-Gui provides an intuitive graphical interface to configure
 various aspects of the glava audio visualizer, including positioning,
 colors, visualizer type, and other settings.
EOF

    cat > debian/rules << 'EOF'
#!/usr/bin/make -f
%:
	dh $@

override_dh_auto_install:
	mkdir -p debian/glava-config-gui/usr/local/bin
	mkdir -p debian/glava-config-gui/usr/share/applications
	cp glava-config-gui debian/glava-config-gui/usr/local/bin/
	chmod +x debian/glava-config-gui/usr/local/bin/glava-config-gui
	cp glava-config-gui.desktop debian/glava-config-gui/usr/share/applications/
EOF

    cat > debian/changelog << 'EOF'
glava-config-gui (1.0.0) unstable; urgency=medium

  * Initial release

 -- BlackoneBc <jlm2@freenet.de>  Fri, 13 Jun 2026 17:00:00 +0000
EOF

    chmod +x debian/rules
}

# Create PKGBUILD for Arch
create_arch_package() {
    cat > PKGBUILD << 'EOF'
pkgname=glava-config-gui
pkgver=1.0.0
pkgrel=1
pkgdesc="GTK4 GUI to configure the glava audio visualizer"
arch=('any')
url="https://github.com/BlackoneBc/Glava-Config-Gui"
license=('MIT')
depends=('python' 'python-gobject' 'gtk4' 'libadwaita' 'psmisc' 'glava')
source=("https://raw.githubusercontent.com/BlackoneBc/Glava-Config-Gui/main/glava-config-gui"
        "https://raw.githubusercontent.com/BlackoneBc/Glava-Config-Gui/main/glava-config-gui.desktop")
sha256sums=('SKIP' 'SKIP')

package() {
    install -Dm755 "$srcdir/glava-config-gui" "$pkgdir/usr/local/bin/glava-config-gui"
    install -Dm644 "$srcdir/glava-config-gui.desktop" "$pkgdir/usr/share/applications/glava-config-gui.desktop"
}
EOF
}

echo "Debian package structure created in debian/"
echo "PKGBUILD created for Arch Linux"
