#!/bin/bash

set -x
pushd .

cd ../../nghttp2

NDK="/opt/android-ndk/"
#export TOOLCHAIN="/opt/android-ndk/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64"
#export PATH=$TOOLCHAIN/bin:$PATH
#export SYSROOT=/opt/android-ndk/platforms/android-9/arch-arm/
#export ABI="arm-linux-androideabi"
NGHTTP2="${PWD}"



autoreconf -i

for ABI in "armeabi-v7a" "armeabi" "x86"; do

    PREFIX=${NGHTTP2}/android/${ABI}
    DEST="../build/android/libs/$ABI"

    if [ "$ABI" = "x86" ]; then
        ARCH="x86"
        HOST="i686-linux-android"
        TOOLCHAIN=`echo $NDK/toolchains/x86-4.9/prebuilt/*-x86*`
    else
        ARCH="arm"
        HOST="arm-linux-androideabi"
        TOOLCHAIN=`echo $NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/*-x86*`
    fi
    SYSROOT=$NDK/platforms/android-9/arch-$ARCH
    # Expand the prebuilt/* path into the correct one
    export PATH=$TOOLCHAIN/bin:$PATH

    ./configure \
        --disable-app \
        --disable-shared \
        --disable-threads \
        --enable-lib-only \
        --host="$HOST" \
        --with-sysroot="$SYSROOT" \
        --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` \
        --without-libxml2 \
        --disable-python-bindings \
        --disable-examples \
        CC="$TOOLCHAIN"/bin/$HOST-gcc \
        CXX="$TOOLCHAIN"/bin/$HOST-g++ \
        CPPFLAGS="-fPIE --sysroot=$SYSROOT -I$SYSROOT/usr/include" \
        LDFLAGS="-fPIE -pie --sysroot=$SYSROOT -L$SYSROOT/usr/lib"


    make
    make install DESTDIR=$PREFIX
    make clean

    cp -av $PREFIX/usr/local/lib/*.a  $DEST

done



popd
set +x