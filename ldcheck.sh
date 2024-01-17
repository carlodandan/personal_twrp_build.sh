#!/bin/bash

source ./vars.sh

# Clone ldchecker
if [ ! -d ldcheck ]; then
git clone https://github.com/that1/ldcheck
fi

# Move ldchecker
if [ ! -f ${BUILD_DIRECTORY}/ldcheck/ldcheck ]; then
mkdir -p ${BUILD_DIRECTORY}/ldcheck
mv ldcheck/* ${BUILD_DIRECTORY}/ldcheck
fi

# Enter Build directory
cd ${BUILD_DIRECTORY}

# Run envsetup for OUT_DIR
source build/envsetup.sh
lunch ${DEVICE_MAKEFILE}-eng

# Run ldchecker
python3 ldcheck/ldcheck -p $OUT/recovery/root/vendor/lib64:$OUT/recovery/root/system/lib64:$OUT/recovery/root/vendor/lib64/hw:$OUT/recovery/root/system/lib64/hw -d $OUT/recovery/root/${LD_CHECK}


