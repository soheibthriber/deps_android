#!/bin/bash

set -x
set -e
pushd .

SCRIPT_DIR="$(readlink -f $(dirname $0))"

export ANDROID_SDK_ROOT=/opt/android-sdk
export ANDROID_NDK_ROOT=/opt/android-ndk
export API=23

cd ../../ffmpeg-kit

git apply "$SCRIPT_DIR/ffmpeg-kit_ffmpeg5.patch" || echo "Patch already applied or inapplicable."

./android.sh --enable-libaom --api-level=$API --disable-arm-v7a-neon --disable-arm64-v8a --disable-x86-64 --no-archive

FF_DIR=$SCRIPT_DIR/jni/ffmpeg

cd $FF_DIR
mkdir -p armeabi-v7a x86
cd -

cp -av prebuilt/android-arm/ffmpeg/* $FF_DIR/armeabi-v7a/
# cp -av prebuilt/android-arm64/ffmpeg/* $FF_DIR/arm64-v8a/
cp -av prebuilt/android-x86/ffmpeg/* $FF_DIR/x86/

popd
set +x
