#!/bin/sh

mkdir -p ../gpac_public/extra_lib/include/
cp -ra build/android/jni/ffmpeg/*/include/lib* ../gpac_public/extra_lib/include/
cp -ra include/* ../gpac_public/extra_lib/include/

mkdir -p ../gpac_public/extra_lib/include/openssl_android
cp -ra openssl/include/openssl ../gpac_public/extra_lib/include/openssl_android/

# mkdir -p ../gpac_public/extra_lib/lib/android/armeabi
# cp -rav lib/android/armeabi/*.so ../gpac_public/extra_lib/lib/android/armeabi
# cp -rav lib/android/armeabi/*.a ../gpac_public/extra_lib/lib/android/armeabi

mkdir -p ../gpac_public/extra_lib/lib/android/armeabi-v7a
cp -rav lib/android/armeabi-v7a/*.so ../gpac_public/extra_lib/lib/android/armeabi-v7a
cp -rav lib/android/armeabi-v7a/*.a ../gpac_public/extra_lib/lib/android/armeabi-v7a

# mkdir -p ../gpac_public/extra_lib/lib/android/arm64-v8a
# cp -rav lib/android/arm64-v8a/*.so ../gpac_public/extra_lib/lib/android/arm64-v8a
# cp -rav lib/android/arm64-v8a/*.a ../gpac_public/extra_lib/lib/android/arm64-v8a

mkdir -p ../gpac_public/extra_lib/lib/android/x86
cp -rav lib/android/x86/*.so ../gpac_public/extra_lib/lib/android/x86
cp -rav lib/android/x86/*.a ../gpac_public/extra_lib/lib/android/x86

mkdir -p ../gpac_public/applications/osmo4_android/libs
cp -fv ./real3d.jar ../gpac_public/applications/osmo4_android/libs
