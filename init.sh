#!/bin/bash

source ./vars.sh

PROJECT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

echo "Setup initial directory..."
if [ ! -d ${BUILD_DIRECTORY} ]; then
  mkdir -p ${BUILD_DIRECTORY}
fi

# Git Config
git config --global user.name "Carlo Dandan"
git config --global user.email "carlodandan.personal@proton.me"

# Cleanup
echo "Clean Build Environment? [y/n]"
read clean_build_env
if [ "${clean_build_env}" = "y" ]; then
  bash cleanup.sh
fi

# Environment
echo "Update Build Environment? [y/n]"
read ask_build_env
if [ "${ask_build_env}" = "y" ]; then
  bash env.sh
fi

# Sync Manifest
if [ -f ${BUILD_DIRECTORY}/build/envsetup.sh ]; then
  echo "Source already synced."
else
  bash sync.sh
fi

# Device Tree
if [ ! -d ${BUILD_DIRECTORY}/${DEVICE_PATH} ]; then
  bash dt.sh
fi

# Pull
cd ${PROJECT_DIR}
echo "Do a git pull? [y/n]"
read gitpull
if [ "${gitpull}" = "y" ]; then
  cd ${BUILD_DIRECTORY}/${DEVICE_PATH}
  git pull
  cd ${PROJECT_DIR}
else
  cd ${PROJECT_DIR}
fi

# Build
echo "Build? [y/n]"
read build
if [ "${build}" = "y" ]; then
  bash build.sh
fi

# Upload
echo "Upload? [y/n]"
read upload
if [ "${upload}" = "y" ]; then
  bash upload.sh
fi