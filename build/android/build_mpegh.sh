#!/bin/bash

set -x
pushd .

cd ../../mpeghdec

sed -i 's/git@github.com:/https:\/\/github.com\//'  CMakeLists.txt


NDK="/opt/android-ndk/"
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

MPEGH="${PWD}"

# Set this to your minSdkVersion.
export API=23


# for ABI in "arm64-v8a" "armeabi-v7a" "x86"; do
for ABI in "armeabi-v7a" "x86"; do

    PREFIX=${MPEGH}/android/${ABI}
    DEST="../build/android/libs/$ABI"

    cmake -S . -B $PREFIX  -DANDROID_ARM_MODE=arm -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DANDROID_ABI=$ABI -DANDROID_PLATFORM=android-$API -DCMAKE_BUILD_TYPE=Release -Dmpeghdec_BUILD_BINARIES=OFF -Dmpeghdec_BUILD_DOC=OFF
    cmake --build $PREFIX --parallel 4

    # if [ "$ABI" = "x86" ]; then
    #     TARGET="i686-linux-android"
    # elif [ "$ABI" = "armeabi-v7a" ]; then
    #     TARGET="armv7a-linux-androideabi"
    # elif [ "$ABI" = "arm64-v8a" ]; then
    #     TARGET="aarch64-linux-android"
    # fi

    # export AR=$TOOLCHAIN/bin/llvm-ar
    # export CC=$TOOLCHAIN/bin/$TARGET$API-clang
    # export AS=$CC
    # export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
    # export LD=$TOOLCHAIN/bin/ld
    # export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
    # export STRIP=$TOOLCHAIN/bin/llvm-strip


    # SYSROOT=$TOOLCHAIN/sysroot

    # # export PATH=$TOOLCHAIN/bin:$PATH

    # ./configure \
    #     --disable-app \
    #     --disable-shared \
    #     --disable-threads \
    #     --enable-lib-only \
    #     --host="$TARGET" \
    #     --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE` \
    #     --without-libxml2 \
    #     --disable-python-bindings \
    #     --disable-examples \
    #     --with-sysroot="$SYSROOT" \
    #     CPPFLAGS="-fPIC -fpic --sysroot=$SYSROOT -I$SYSROOT/usr/include" \
    #     LDFLAGS="-fPIC -fpic --sysroot=$SYSROOT -L$SYSROOT/usr/lib"



    # make
    # make install DESTDIR=$PREFIX
    # make clean

    mkdir -p "$DEST"
    cp -av $PREFIX/lib/*.a  $DEST

done



popd
set +x