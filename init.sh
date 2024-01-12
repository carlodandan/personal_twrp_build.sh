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

# This is to avoid .git issues about too much changes happens at once or continously.
echo "Add .gitignore"
if [ ! -f .gitignore ]; then
  echo "**/slimhub_actions
**/android" >> .gitignore
fi

# Cleanup
echo "Clean Build Environment? [yes/no]"
read clean_build_env
if [ "${clean_build_env}" = "yes" ]; then
  bash cleanup.sh
fi

# Environment
echo "Update Build Environment? [yes/no]"
read ask_build_env
if [ "${ask_build_env}" = "yes" ]; then
  bash env.sh
fi

# Sync Manifest
if [ -f ${BUILD_DIRECTORY}/build/envsetup.sh ]; then
  echo "Source already synced."
else
  bash sync.sh
fi

# Device Tree
if [ ! -d ${DEVICE_PATH} ]; then
  bash dt.sh
fi

