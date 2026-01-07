#!/usr/bin/env bash
set -e

# =========================
# TLP Battery Cap Installer
# =========================

START=80
STOP=85

echo "[+] Installing TLP..."
sudo apt update
sudo apt install -y tlp tlp-rdw

echo "[+] Enabling and starting TLP..."
sudo systemctl enable tlp --now

CONF="/etc/tlp.conf"

echo "[+] Configuring battery thresholds in $CONF"

# Backup once
if [ ! -f "${CONF}.bak" ]; then
    sudo cp "$CONF" "${CONF}.bak"
    echo "[+] Backup created: ${CONF}.bak"
fi

# Remove existing BAT threshold lines
sudo sed -i \
    -e '/START_CHARGE_THRESH_BAT/d' \
    -e '/STOP_CHARGE_THRESH_BAT/d' \
    "$CONF"

# Append new config
sudo tee -a "$CONF" > /dev/null <<EOF

# ---- Lenovo battery charge thresholds ----
START_CHARGE_THRESH_BAT0=$START
STOP_CHARGE_THRESH_BAT0=$STOP
EOF

echo "[+] Restarting TLP to apply changes..."
sudo tlp start

echo "[+] Verifying battery configuration:"
sudo tlp-stat -b | sed -n '/Charge thresholds/,/Charge control/p'

echo "[✓] Battery charge capped at ${STOP}% (starts charging below ${START}%)"
