#!/bin/bash

source ./vars.sh

echo ${BUILD_DIRECTORY}
cd ${BUILD_DIRECTORY}

source build/envsetup.sh
lunch ${DEVICE_MAKEFILE}-eng

curl --upload-file $OUT/${BUILD_TARGET}.img https://transfer.sh/${BUILD_TARGET}.img > ${PROJECT_DIR}/download.txt

cd ${PROJECT_DIR}