#!/bin/bash
set -e

PKG_NAME="discord-updater"
VERSION="1.0.3"
BUILD_DIR="${PKG_NAME}_${VERSION}"

# Cleanup old builds
rm -rf "$BUILD_DIR" "${PKG_NAME}_${VERSION}.deb"

# Create directory structure
mkdir -p "$BUILD_DIR/DEBIAN"
mkdir -p "$BUILD_DIR/usr/local/bin"
mkdir -p "$BUILD_DIR/etc/systemd/system"

# Copy files
install -m 755 update_discord.sh "$BUILD_DIR/usr/local/bin/update_discord.sh"
install -m 644 update-discord.service "$BUILD_DIR/etc/systemd/system/update-discord.service"
install -m 644 update-discord.timer "$BUILD_DIR/etc/systemd/system/update-discord.timer"

# Create control file
cat > "$BUILD_DIR/DEBIAN/control" <<EOF
Package: $PKG_NAME
Version: $VERSION
Section: utils
Priority: optional
Architecture: all
Depends: systemd
Maintainer: MartinK7 <martinelekt@seznam.cz>
Description: Auto-update service for Discord on Ubuntu
 Installs a script and a systemd service to automatically update Discord.
EOF

# Create postinst script
cat > "$BUILD_DIR/DEBIAN/postinst" <<'EOF'
#!/bin/sh
set -e
systemctl daemon-reload
systemctl enable --now update-discord.service || true
systemctl enable --now update-discord.timer || true
exit 0
EOF
chmod 755 "$BUILD_DIR/DEBIAN/postinst"

# Create prerm script
cat > "$BUILD_DIR/DEBIAN/prerm" <<'EOF'
#!/bin/sh
set -e
systemctl disable --now update-discord.service || true
systemctl disable --now update-discord.timer || true
systemctl daemon-reload
exit 0
EOF
chmod 755 "$BUILD_DIR/DEBIAN/prerm"

# Build deb package
dpkg-deb --build "$BUILD_DIR"

echo "Package built: ${BUILD_DIR}.deb"

