#!/bin/bash

source ./vars.sh

# Sync Manifest
cd ${BUILD_DIRECTORY}
repo init --depth=1 -u ${MANIFEST} -b ${MANIFEST_BRANCH}
repo sync -j$(nproc --all) --force-sync
echo "Done syncing manifest source."