#!/bin/bash

source ./vars.sh

PROJECT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

# Environment
export DEBIAN_FRONTEND=noninteractive
sudo apt -y update && \
sudo apt -y upgrade && \
sudo apt -y install rsync gperf gcc-multilib gcc-10-multilib g++-multilib g++-10-multilib libc6-dev lib32ncurses5-dev x11proto-core-dev libx11-dev tree lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc bc ccache lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-gtk3-dev libxml2 lzop pngcrush schedtool squashfs-tools imagemagick libbz2-dev lzma ncftp qemu-user-static libstdc++-10-dev libtinfo5 libgflags-dev python3 python-is-python3
echo "Done setting up build environment."

# Git-Repo Tool
mkdir -p ~/bin
if [ ! -f ~/bin/repo ]; then
  curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
  chmod a+x ~/bin/repo
  sudo ln -sf ~/bin/repo /usr/bin/repo
  echo "Done setting up git-repo tool."
fi