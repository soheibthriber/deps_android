#!/bin/sh

set -x


if [ ! -d aom ]; then
   git clone https://aomedia.googlesource.com/aom
fi

# this version woks well with ffmpeg 4.0.2
# if we update aom, we need to update ffmpeg to 4.1+
cd aom
git checkout cf38e96db7664ae82d8d67287fa0c4a60b44473b
cd ..


ABIS="armeabi-v7a x86"


for ABI in $ABIS ; do

    mkdir $ABI
    cd $ABI

    if [ "$1" = "rebuild" ] || [ ! -f Makefile ] ; then
            cmake ../aom -DCMAKE_TOOLCHAIN_FILE=../$ABI-android.cmake
    fi

    make aom
    cd ..

done



for i in $ABIS ; do


cat <<EOF > $i/aom.pc
# libaom pkg-config
prefix=$(pwd)/aom
exec_prefix=$(pwd)/$i/bin
libdir=$(pwd)/$i
includedir=$(pwd)/aom

Name: aom
Description: AV1 codec library
Version: 1.0.0
Requires:
Conflicts:
Libs: -L$(pwd)/$i -laom -lm
Libs.private: -lm
Cflags: -I$(pwd)/aom
EOF

done


set +x

