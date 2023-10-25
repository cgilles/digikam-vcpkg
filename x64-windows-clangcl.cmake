# VCPKG tool-chain definitions to cross-compile with clang-cl under Linux.
#
# Copyright (c) 2015-2023, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE dynamic)

set(VCPKG_BUILD_TYPE release)

set(ENV{HOST_ARCH} ${VCPKG_TARGET_ARCHITECTURE})

set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE /mnt/data/qt.msvc/clang_windows_sdk/clang-cl-msvc.cmake)

set(ENV{VCPKG_TOOLCHAIN} "/mnt/data/qt.msvc/vcpkg/scripts/toolchains/windows.cmake")

set(VCPKG_POLICY_SKIP_ARCHITECTURE_CHECK enabled)
