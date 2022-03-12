#!/bin/bash

set -x
pushd .

cd ../../nghttp2

NDK="/opt/android-ndk/"
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

NGHTTP2="${PWD}"

# Set this to your minSdkVersion.
export API=23


autoreconf -i

for ABI in "armeabi-v7a" "x86"; do

    PREFIX=${NGHTTP2}/android/${ABI}
    DEST="../build/android/libs/$ABI"

    if [ "$ABI" = "x86" ]; then
        TARGET="i686-linux-android"
    elif [ "$ABI" = "armeabi-v7a" ]; then
        TARGET="armv7a-linux-androideabi"
    elif [ "$ABI" = "arm64-v8a" ]; then
        TARGET="aarch64-linux-android"
    fi

    export AR=$TOOLCHAIN/bin/llvm-ar
    export CC=$TOOLCHAIN/bin/$TARGET$API-clang
    export AS=$CC
    export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
    export LD=$TOOLCHAIN/bin/ld
    export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
    export STRIP=$TOOLCHAIN/bin/llvm-strip


    SYSROOT=$TOOLCHAIN/sysroot

    # export PATH=$TOOLCHAIN/bin:$PATH

    ./configure \
        --disable-app \
        --disable-shared \
        --disable-threads \
        --enable-lib-only \
        --host="$TARGET" \
        --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` \
        --without-libxml2 \
        --disable-python-bindings \
        --disable-examples \
        --with-sysroot="$SYSROOT" \
        CPPFLAGS="-fPIC -fpic --sysroot=$SYSROOT -I$SYSROOT/usr/include" \
        LDFLAGS="-fPIC -fpic --sysroot=$SYSROOT -L$SYSROOT/usr/lib"



    make
    make install DESTDIR=$PREFIX
    make clean

    mkdir -p "$DEST"
    cp -av $PREFIX/usr/local/lib/*.a  $DEST

done



popd
set +x