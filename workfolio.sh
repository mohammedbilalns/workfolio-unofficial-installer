#!/bin/bash
set -e

pkg_path="https://workfolio-public.s3.ap-south-1.amazonaws.com/"
pkg_file="workfolio_0.1.46_amd64.deb"

mkdir -p workfolio
cd workfolio

wget "${pkg_path}${pkg_file}"

ar x "${pkg_file}"

tar -xf data.tar.*   

sudo cp -r ./opt/workfolio /opt

sudo cp -rv ./usr/share/* /usr/share/

sudo update-desktop-database
sudo gtk-update-icon-cache /usr/share/icons/hicolor

