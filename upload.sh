#!/bin/bash

source ./vars.sh

echo ${BUILD_DIRECTORY}
cd ${BUILD_DIRECTORY}

source build/envsetup.sh
lunch ${DEVICE_MAKEFILE}-eng

curl bashupload.com -T $OUT/${BUILD_TARGET}.img

cd ${PROJECT_DIR}