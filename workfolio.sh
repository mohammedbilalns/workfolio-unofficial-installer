#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
  SUDO="sudo"
else
  SUDO=""
fi

if command -v pacman >/dev/null 2>&1; then
  echo "Detected Arch-based distro"
  $SUDO pacman -Sy --noconfirm xorg-xwininfo

elif command -v dnf >/dev/null 2>&1; then
  echo "Detected Fedora-based distro"
  $SUDO dnf install -y xwininfo

else
  echo "Unsupported distribution: No known package manager found"
  exit 1
fi

pkg_path="https://workfolio-public.s3.ap-south-1.amazonaws.com/"
pkg_file="workfolio_0.1.46_amd64.deb"

mkdir -p workfolio
cd workfolio

wget "${pkg_path}${pkg_file}"

ar x "${pkg_file}"

tar -xf data.tar.*   

$SUDO cp -r ./opt/workfolio /opt

$SUDO cp -rv ./usr/share/* /usr/share/

sudo update-desktop-database
sudo gtk-update-icon-cache /usr/share/icons/hicolor

