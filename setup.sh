#!/usr/bin/env bash
set -e

# ─────────────────────────────────────────────
# Pacman packages
# ─────────────────────────────────────────────
sudo pacman -Syu --needed --noconfirm \
  base-devel git \
  hyprland hyprpaper hyprlock waybar \
  rofi fastfetch neovim nerd-fonts ghostty copyq grim slurp\
  nvidia-dkms nvidia-utils lib32-nvidia-utils libva-nvidia-driver

# ─────────────────────────────────────────────
# NVIDIA DRM KMS
# ─────────────────────────────────────────────
sudo mkdir -p /etc/modprobe.d
echo "options nvidia_drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf

# Add NVIDIA modules safely
if ! grep -q "nvidia_drm" /etc/mkinitcpio.conf; then
  sudo sed -i 's/^MODULES=(/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm /' /etc/mkinitcpio.conf
fi

sudo mkinitcpio -P

# Add user to video/render
sudo usermod -aG wheel,video,render,audio,storage,input $USER
sudo usermod -aG lp $USER

# ─────────────────────────────────────────────
# Install yay (run as user)
# ─────────────────────────────────────────────
if ! command -v yay &>/dev/null; then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
fi

# ─────────────────────────────────────────────
# AUR packages
# ─────────────────────────────────────────────
yay -S --needed --noconfirm brave-origin-nightly

# ─────────────────────────────────────────────
# Copy configs
# ─────────────────────────────────────────────
CONFIG_DIR="$HOME/.config"
mkdir -p "$CONFIG_DIR"

cp -r hypr fastfetch rofi waybar nvim ghostty"$CONFIG_DIR/" 2>/dev/null || true

echo "Full setup complete."
echo "Please Reboot."
