#!/bin/bash

set -x
set -e
pushd .

cd ../../openssl

export ANDROID_NDK_HOME="/opt/android-ndk"

SSLDIR="${PWD}"

#for ABI in "armeabi-v7a" ; do
for ABI in "armeabi" "armeabi-v7a" "x86"; do

    PREFIX=${SSLDIR}/android/${ABI}
    DEST1="../build/android/libs/$ABI"
    DEST2="../lib/android/$ABI"

    if [ "$ABI" = "x86" ]; then
        ARCH="android-x86"
        HOST="i686-linux-android"
        TOOLCHAIN=`echo $ANDROID_NDK_HOME/toolchains/x86-4.9/prebuilt/*-x86*`
    else
        ARCH="android-arm"
        HOST="arm-linux-androideabi"
        TOOLCHAIN=`echo $ANDROID_NDK_HOME/toolchains/arm-linux-androideabi-4.9/prebuilt/*-x86*`
    fi
    #SYSROOT=$ANDROID_NDK_HOME/platforms/android-9/arch-$ARCH
    # Expand the prebuilt/* path into the correct one
    export PATH=$TOOLCHAIN/bin:$PATH

    make clean || true
    # make update
    ./Configure $ARCH -no-threads -D__ANDROID_API__=9
    make -j4 build_libs SHLIB_VERSION_NUMBER= SHLIB_EXT=.so
    make install_dev DESTDIR=$PREFIX SHLIB_VERSION_NUMBER= SHLIB_EXT=.so


    cp -Lv $PREFIX/usr/local/lib/*.{a,so}  $DEST1
    cp -Lv $PREFIX/usr/local/lib/*.{a,so}  $DEST2

done



popd
set +x
