#!/bin/bash

set -x
set -e
pushd .

cd ../../openssl

export NDK="/opt/android-ndk"
export ANDROID_NDK_HOME="$NDK"
export API=23

export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
export PATH=$TOOLCHAIN/bin:$PATH

SSLDIR="${PWD}"

for ABI in "armeabi-v7a" "x86" "arm64-v8a"; do

    PREFIX=${SSLDIR}/android/${ABI}
    DEST1="../build/android/libs/$ABI"
    DEST2="../lib/android/$ABI"


    if [ "$ABI" = "x86" ]; then
        ARCH="android-x86"
        TARGET="i686-linux-android"
    elif [ "$ABI" = "armeabi-v7a" ]; then
        ARCH="android-arm"
        TARGET="armv7a-linux-androideabi"
    elif [ "$ABI" = "arm64-v8a" ]; then
        ARCH="android-arm64"
        TARGET="aarch64-linux-android"
    fi

    export AR=$TOOLCHAIN/bin/llvm-ar
    export CC=$TOOLCHAIN/bin/$TARGET$API-clang
    export AS=$CC
    export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
    export LD=$TOOLCHAIN/bin/ld
    export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
    export STRIP=$TOOLCHAIN/bin/llvm-strip

    make clean || true
    # make update
    ./Configure $ARCH -no-threads -U__ANDROID_API__  -D__ANDROID_API__=$API
    make -j4 build_libs SHLIB_VERSION_NUMBER= SHLIB_EXT=.so
    make install_dev DESTDIR=$PREFIX SHLIB_VERSION_NUMBER= SHLIB_EXT=.so

    mkdir -p "$DEST1" "$DEST2"
    cp -Lv $PREFIX/usr/local/lib/*.{a,so}  $DEST1
    cp -Lv $PREFIX/usr/local/lib/*.{a,so}  $DEST2

done



popd
set +x
