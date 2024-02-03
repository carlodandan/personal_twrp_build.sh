#!/bin/bash

PROJECT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
MANIFEST="https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp"
MANIFEST_BRANCH="twrp-12.1"
DEVICE_TREE="https://github.com/cd-Crypton/custom_recovery_tree_xiaomi_cannong"
DEVICE_BRANCH="twrp-12.1"
DEVICE_PATH="device/xiaomi/cannong"
DEVICE_MAKEFILE="twrp_cannong"
BUILD_TARGET="recovery"
BUILD_DIRECTORY="android/recovery"
LD_CHECK="vendor/lib64/hw/*.so"