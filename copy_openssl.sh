#!/bin/sh

SSLDIR="./OpenSSL-for-Android-Prebuilt/openssl-1.1.1k-clang"
GPACDIR="../gpac_public/extra_lib"

# copy includes to gpac
mkdir -p "$GPACDIR/include/openssl_android"
cp -ra "$SSLDIR/include/"* "$GPACDIR/include/openssl_android"

# copy libs with the other android deps
# they will be copied to gpac along with the other with ./CopyLibs2Public4Android.sh
cp -Lv "$SSLDIR/x86/lib/"*.a "lib/android/x86"
cp -Lv "$SSLDIR/x86/lib/"*.so "lib/android/x86"
cp -Lv "$SSLDIR/armeabi-v7a/lib/"*.a "lib/android/armeabi"
cp -Lv "$SSLDIR/armeabi-v7a/lib/"*.so "lib/android/armeabi"
cp -Lv "$SSLDIR/armeabi-v7a/lib/"*.a "lib/android/armeabi-v7a"
cp -Lv "$SSLDIR/armeabi-v7a/lib/"*.so "lib/android/armeabi-v7a"
