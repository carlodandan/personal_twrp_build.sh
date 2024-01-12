#!/bin/bash

source ./vars.sh

# Clone Device Tree
cd ${PROJECT_DIR}/${BUILD_DIRECTORY}
git clone --depth=1 ${DEVICE_TREE} -b ${DEVICE_BRANCH} ${DEVICE_PATH}
cd ${PROJECT_DIR}