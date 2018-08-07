#
# Copyright (c) 2017, Alliance for Open Media. All rights reserved
#
# This source code is subject to the terms of the BSD 2 Clause License and the
# Alliance for Open Media Patent License 1.0. If the BSD 2 Clause License was
# not distributed with this source code in the LICENSE file, you can obtain it
# at www.aomedia.org/license/software. If the Alliance for Open Media Patent
# License 1.0 was not distributed with this source code in the PATENTS file, you
# can obtain it at www.aomedia.org/license/patent.
#
if(AOM_BUILD_CMAKE_TOOLCHAINS_X86_LINUX_GCC_CMAKE_)
  return()
endif() # AOM_BUILD_CMAKE_TOOLCHAINS_X86_LINUX_GCC_CMAKE_
set(AOM_BUILD_CMAKE_TOOLCHAINS_X86_LINUX_GCC_CMAKE_ 1)

set(CMAKE_SYSTEM_NAME "Linux")

LIST(APPEND CMAKE_PROGRAM_PATH  "/opt/android-ndk/toolchains/x86-4.9/prebuilt/linux-x86_64/bin" )

if("${CROSS}" STREQUAL "")

  # Default the cross compiler prefix to something known to work.
  set(CROSS i686-linux-android-)
endif()

#if(NOT ${CROSS} MATCHES hf-$)
#  set(AOM_EXTRA_TOOLCHAIN_FLAGS "-mfloat-abi=softfp")
#endif()

set(CMAKE_SYSROOT /opt/android-ndk/platforms/android-21/arch-x86)

set(CMAKE_C_COMPILER ${CROSS}gcc)
set(CMAKE_CXX_COMPILER ${CROSS}g++)
set(AS_EXECUTABLE yasm)
set(CMAKE_C_COMPILER_ARG1 "-m32")
set(CMAKE_CXX_COMPILER_ARG1 "-m32")
#set(AOM_AS_FLAGS -march=i686)
set(CMAKE_SYSTEM_PROCESSOR "x86")


SET(CMAKE_C_FLAGS " -I/opt/android-ndk/sources/cxx-stl/gnu-libstdc++/4.9/include -I/opt/android-ndk/sources/cxx-stl/gnu-libstdc++/4.9/libs/x86/include " CACHE STRING "" FORCE)
SET(CMAKE_CXX_FLAGS " -I/opt/android-ndk/sources/cxx-stl/gnu-libstdc++/4.9/include -I/opt/android-ndk/sources/cxx-stl/gnu-libstdc++/4.9/libs/x86/include " CACHE STRING "" FORCE)
link_directories(/opt/android-ndk/platforms/android-21/arch-x86/usr/lib)

