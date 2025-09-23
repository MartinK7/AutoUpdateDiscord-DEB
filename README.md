# Automatic Discord Update

This repository provides a complete solution to automatically update Discord on Linux systems using a systemd service. A `.deb` package is available in the GitHub releases for easy installation.

## Installation

### Using the GitHub Release

1. Download the latest `.deb` package from the [Releases](https://github.com/MartinK7/AutoUpdateDiscord-DEB/releases) page.  
2. Install the package:

```bash
sudo dpkg -i discord-updater_1.0.5.deb
````

The installation automatically copies the script and service to the correct locations, enables the service, and starts it.

### Uninstallation

To remove the package:

```bash
sudo apt remove discord-updater
```

To completely purge all files:

```bash
sudo apt purge discord-updater
```

## Building the DEB Package

If you want to build the `.deb` package yourself:

1. Make sure `update_discord.sh` and `update-discord.service` are in the repository root.
2. Run the build script:

```bash
./make_deb.sh
```

This will create `discord-updater_1.0.1.deb` in the same directory.

## Service Management

Once installed via the `.deb`, the systemd service runs automatically.
You can manage it with standard systemctl commands:

```bash
sudo systemctl status update-discord.service
sudo systemctl restart update-discord.service
sudo systemctl stop update-discord.service
sudo systemctl disable update-discord.service
```
