#!/bin/bash

MANIFEST="https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp"
MANIFEST_BRANCH="twrp-12.1"
DEVICE_TREE="https://github.com/cd-Crypton/custom_recovery_tree_xiaomi_cannong"
DEVICE_BRANCH="twrp-12.1"
DEVICE_PATH="device/xiaomi/cannong"
DEVICE_MAKEFILE="twrp_cannong"
BUILD_TARGET="recovery"
BUILD_DIRECTORY="android/recovery"

function _buildMsg() {
cat <<EOBT

  ╔══════════════════════════════════════════════════════════════╗
  ║              Build TeamWin Recovery Project                  ║
  ╚══════════════════════════════════════════════════════════════╝

EOBT
}

# Print the Warning Message
printf "\e[33;1;2m" && _buildMsg && printf "\e[0m" && sleep 1s

echo "Setup initial directory..."
if [ ! -d ${BUILD_DIRECTORY} ]; then
  mkdir -p ${BUILD_DIRECTORY}
fi

# This is to avoid .git issues about too much changes happens at once or continously.
echo "Add .gitignore"
if [ ! -f .gitignore ]; then
  echo "**/slimhub_actions
  **/android" >> .gitignore
fi

# Cleanup
if [ ! -d slimhub_actions ]; then
  git clone https://github.com/carlodandan/slimhub_actions -b main
  sudo bash slimhub_actions/cleanup.sh
else
  sudo bash slimhub_actions/cleanup.sh
fi

# Environment
export DEBIAN_FRONTEND=noninteractive
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install rsync gperf gcc-multilib gcc-10-multilib g++-multilib g++-10-multilib libc6-dev lib32ncurses5-dev x11proto-core-dev libx11-dev tree lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc bc ccache lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-gtk3-dev libxml2 lzop pngcrush schedtool squashfs-tools imagemagick libbz2-dev lzma ncftp qemu-user-static libstdc++-10-dev libtinfo5 libgflags-dev python3 python-is-python3
echo "Done setting up build environment."

# Git-Repo Tool
mkdir -p ~/bin
if [ ! -d ~/bin/repo ]; then
  curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
  chmod a+x ~/bin/repo
  sudo ln -sf ~/bin/repo /usr/bin/repo
  echo "Done setting up git-repo tool."
fi

# Git Config
git config --global user.name "Carlo Dandan"
git config --global user.email "carlodandan.personal@proton.me"

# Sync Manifest
cd ${BUILD_DIRECTORY}
if [ ! -f build/envsetup.sh ]; then
  repo init --depth=1 -u ${MANIFEST} -b ${MANIFEST_BRANCH}
  repo sync -j$(nproc --all) --force-sync
  cd ../..
  echo "Done syncing manifest source."
else
  cd ../..
fi

# Clone Device Tree
cd android/recovery
if [ ! -d device/xiaomi/cannong ]; then
  git clone --depth=1 ${DEVICE_TREE} -b ${DEVICE_BRANCH} ${DEVICE_PATH}
  cd ../..
  echo "Done cloning device tree."
else
  cd ../..
fi

# Build
cd android/recovery
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch ${DEVICE_MAKEFILE}-eng && mka ${BUILD_TARGET}image
echo "Your TWRP is no ready. Check in $OUT folder"




