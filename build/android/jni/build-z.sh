#!/bin/bash

set -e

# Define paths
NDK_PATH="/opt/android-ndk"
PROJECT_DIR=$(pwd) # Assumes the script is run from the jni directory
OUTPUT_DIR="$PROJECT_DIR/libs"

# Define architecture and target
TARGET_ARCH="arm64-v8a"
APP_PLATFORM="android-34"

# Export NDK environment variables
export NDK_PROJECT_PATH=$PROJECT_DIR
export APP_ABI=$TARGET_ARCH
export APP_PLATFORM=$APP_PLATFORM

# Ensure NDK path is valid
if [ ! -d "$NDK_PATH" ]; then
    echo "Error: NDK path not found: $NDK_PATH"
    exit 1
fi

# Build the library
echo "Building FreeType for $TARGET_ARCH..."
$NDK_PATH/ndk-build \
    NDK_PROJECT_PATH=$PROJECT_DIR \
    APP_ABI=$TARGET_ARCH \
    APP_PLATFORM=$APP_PLATFORM \
    APP_STL=c++_shared \
    APP_OPTIM=release \
    APP_BUILD_SCRIPT=$PROJECT_DIR/lib_zlibdroid.mk

# Check for build success
if [ -f "$OUTPUT_DIR/$TARGET_ARCH/libz.so" ]; then
    echo "Build successful! Library located at: $OUTPUT_DIR/$TARGET_ARCH/libz.so"
else
    echo "Build failed. Check the logs for more details."
    exit 1
fi
