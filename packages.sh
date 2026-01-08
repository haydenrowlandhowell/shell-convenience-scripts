#!/usr/bin/env bash
set -e

echo "Removing NVIDIA"
sudo apt remove nvidia*

# -----------------------------
# Core build & system tools
# -----------------------------
echo "Installing core build tools..."
sudo apt install -y \
  vim \
  build-essential \
  clang \
  clangd \
  gcc \
  g++ \
  git \
  rsync \
  python3 \
  python3-pip \
  python3-venv \
  python3-dev \
  openssh-client \
  vlc \
  synaptic \
  libreoffice-writer \
  openssh-client \
  ipython3

# -----------------------------
# Cleanup
# -----------------------------
echo "Cleaning up..."
sudo apt autoremove -y
sudo apt autoclean

# -----------------------------
# Vim setup
# -----------------------------
cat <<EOF > .vimrc
syntax on
set noswapfile
inoremap jf <esc>
EOF

echo "Developer environment installation complete."
echo "Log out and back in if Docker or pipx were installed."
