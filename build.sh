#!/bin/bash

source ./vars.sh

PROJECT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

function _buildMsg() {
cat <<EOBT

  ╔══════════════════════════════════════════════════════════════╗
  ║              Build TeamWin Recovery Project                  ║
  ╚══════════════════════════════════════════════════════════════╝

EOBT
}

# Print Build Message
printf "\e[33;1;2m" && _buildMsg && printf "\e[0m" && sleep 1s

# Build
cd ${BUILD_DIRECTORY}
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch ${DEVICE_MAKEFILE}-eng && mka ${BUILD_TARGET}image
echo "Your TWRP is now ready. Check in $OUT folder."