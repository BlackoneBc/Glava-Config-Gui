# Glava-Config-Gui

A powerful GTK4/Libadwaita GUI application to configure the **glava** audio visualizer on Linux.

## Features

- 🎨 **Real-time Visualization Preview** - See your visualizer position on the desktop
- 🎵 **Multiple Visualizer Types** - radial, graph, wave, circle, bars
- 🎯 **Precise Positioning** - Set exact pixel coordinates for your visualizer
- 🌈 **Color Customization** - Choose colors and transparency for visualizer effects
- 💾 **Auto-save Configuration** - Changes are automatically written to glava's config
- 🚀 **Autostart Support** - Enable glava to start automatically at login
- 🪟 **Multi-Monitor Support** - Automatically detects all connected monitors

## Installation

### Universal One-Command Installation

Works on **Debian, Ubuntu, Arch, Manjaro, Fedora, and other Linux distros**:

```bash
curl -sSL https://raw.githubusercontent.com/BlackoneBc/Glava-Config-Gui/main/install.sh | bash
```

This script will:
1. ✅ Detect your Linux distribution automatically
2. ✅ Install all required dependencies
3. ✅ Install glava-config-gui to `/usr/local/bin/`
4. ✅ Create a desktop entry in your applications menu

### Manual Installation by Distribution

#### Debian/Ubuntu/Mint/PopOS
```bash
sudo apt update
sudo apt install python3 python3-gi libgtk-4-0 libadwaita-1-0 psmisc glava

# Then download and run the script
curl -sSL https://raw.githubusercontent.com/BlackoneBc/Glava-Config-Gui/main/glava-config-gui -o /tmp/glava-config-gui
sudo mv /tmp/glava-config-gui /usr/local/bin/
sudo chmod +x /usr/local/bin/glava-config-gui
```

#### Arch/Manjaro
```bash
sudo pacman -Sy python python-gobject gtk4 libadwaita psmisc glava

# Then download and run the script
curl -sSL https://raw.githubusercontent.com/BlackoneBc/Glava-Config-Gui/main/glava-config-gui -o /tmp/glava-config-gui
sudo mv /tmp/glava-config-gui /usr/local/bin/
sudo chmod +x /usr/local/bin/glava-config-gui
```

#### Fedora/RHEL/CentOS
```bash
sudo dnf install python3 python3-gobject gtk4-devel libadwaita-devel psmisc glava

# Then download and run the script
curl -sSL https://raw.githubusercontent.com/BlackoneBc/Glava-Config-Gui/main/glava-config-gui -o /tmp/glava-config-gui
sudo mv /tmp/glava-config-gui /usr/local/bin/
sudo chmod +x /usr/local/bin/glava-config-gui
```

#### openSUSE
```bash
sudo zypper install python3 python3-gobject libgtk-4-0 libadwaita-devel psmisc glava

# Then download and run the script
curl -sSL https://raw.githubusercontent.com/BlackoneBc/Glava-Config-Gui/main/glava-config-gui -o /tmp/glava-config-gui
sudo mv /tmp/glava-config-gui /usr/local/bin/
sudo chmod +x /usr/local/bin/glava-config-gui
```

## Usage

### Launch the Application

#### From Terminal
```bash
glava-config-gui
```

#### From Applications Menu
Look for "Glava Config GUI" in your applications menu/launcher (works with KDE, GNOME, Cinnamon, etc.)

#### With Desktop Shortcut
The installer automatically creates a `.desktop` entry, so you can also:
- Search for "Glava" in your application launcher
- Use `pamac search` or similar package manager GUI

### Configuration Options

**General Settings:**
- ✓ Autostart on login
- ✓ Click-through mode (ignore mouse clicks)
- ✓ Keep window below other windows
- ✓ Window mode (desktop, normal, or special)

**Visualizer & Position:**
- ✓ Choose visualizer type (radial, graph, wave, circle, bars)
- ✓ Set width and height in pixels
- ✓ Set X and Y position coordinates
- ✓ Center on desktop with one click
- ✓ Real-time preview of positioning

**Colors & Effects:**
- ✓ Main color picker with transparency
- ✓ Toggle outline/border effects
- ✓ Live preview

**Reset Options:**
- ✓ Reset entire configuration
- ✓ Reset size only
- ✓ Reset position only

## Uninstallation

Remove glava-config-gui from your system using your package manager:

### Debian/Ubuntu/Mint/PopOS
```bash
sudo apt remove glava-config-gui
```

### Arch/Manjaro (with pacman)
```bash
sudo pacman -R glava-config-gui
```

### Arch/Manjaro (with pamac GUI)
```bash
pamac remove glava-config-gui
```

### Fedora/RHEL
```bash
sudo dnf remove glava-config-gui
```

### openSUSE
```bash
sudo zypper remove glava-config-gui
```

## Dependencies

The following system packages are required:

| Debian/Ubuntu | Arch | Fedora | openSUSE |
|---------------|------|--------|----------|
| `python3` | `python` | `python3` | `python3` |
| `python3-gi` | `python-gobject` | `python3-gobject` | `python3-gobject` |
| `libgtk-4-0` | `gtk4` | `gtk4-devel` | `libgtk-4-0` |
| `libadwaita-1-0` | `libadwaita` | `libadwaita-devel` | `libadwaita-devel` |
| `psmisc` | `psmisc` | `psmisc` | `psmisc` |
| `glava` | `glava` | `glava` | `glava` |

The installer script handles all of these automatically.

## System Requirements

- **OS:** Linux (any distribution with GTK4/Libadwaita support)
- **Python:** 3.8 or higher
- **GTK:** 4.0 or higher
- **Libadwaita:** 1.0 or higher
- **Audio:** PulseAudio or PipeWire (for glava audio input)
- **RAM:** ~50 MB
- **Disk:** ~10 MB

## Troubleshooting

### "Command not found: glava-config-gui"
Make sure the installation completed successfully. Try:
```bash
which glava-config-gui
```

If it doesn't return a path, reinstall:
```bash
curl -sSL https://raw.githubusercontent.com/BlackoneBc/Glava-Config-Gui/main/install.sh | bash
```

### Application won't start
Verify all dependencies are installed:
```bash
# Debian/Ubuntu
dpkg -l | grep python3-gi

# Arch
pacman -Q python-gobject

# Fedora
rpm -q python3-gobject
```

### Glava not detected
Make sure `glava` is installed and in your PATH:
```bash
which glava
glava --help
```

## Building from Source

Clone the repository:
```bash
git clone https://github.com/BlackoneBc/Glava-Config-Gui.git
cd Glava-Config-Gui
```

Run directly:
```bash
python3 glava-config-gui
```

Or make it executable:
```bash
chmod +x glava-config-gui
./glava-config-gui
```

## Contributing

Contributions are welcome! Feel free to:
- Report bugs via GitHub Issues
- Suggest features via GitHub Discussions
- Submit pull requests with improvements

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Credits

- **glava** - The original audio visualizer (https://github.com/jarcode-dev/glava)
- **GTK4** - The toolkit used for the GUI
- **Libadwaita** - GNOME's modern UI library

## Support

If you encounter any issues:

1. Check the [Troubleshooting](#troubleshooting) section above
2. Review your Linux distribution's package documentation
3. Open an issue on GitHub: https://github.com/BlackoneBc/Glava-Config-Gui/issues

---

**Happy visualizing! 🎵✨**
