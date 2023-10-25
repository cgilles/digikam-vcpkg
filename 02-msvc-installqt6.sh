#!/bin/bash

################################################################################
#
# Script to install Qt framework for Windows.
#
# Copyright (c) 2013-2023, Gilles Caulier, <caulier dot gilles at gmail dot com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
################################################################################

ORIG_WD="`pwd`"
INSTALL_PREFIX=/mnt/data/qt.msvc
VCPKG_VER="2023.10.19"

# Shared with VCPKG toolchain

export MSVC_BASE=${INSTALL_PREFIX}/clang_windows_sdk/msvc
export MSVC_VER="msvc2019"
export WINSDK_BASE=${INSTALL_PREFIX}/clang_windows_sdk/winsdk
export WINSDK_VER="10.0.19041.0"
export CLANG_VER=15
export LLVM_VER=${CLANG_VER}

if [ ! -d ${INSTALL_PREFIX} ] ; then

    mkdir -p ${INSTALL_PREFIX}

fi


if [ ! -d ${INSTALL_PREFIX}/clang_windows_sdk ] ; then

    echo "Installing Clang Windows SDK for Linux..."

    cd ${INSTALL_PREFIX}

    git clone https://github.com/Nemirtingas/clang-msvc-sdk clang_windows_sdk --depth=1

    git clone https://github.com/Nemirtingas/windowscross_vcpkg "--branch=${MSVC_VER}" --depth=1 "${MSVC_BASE}_tmp"

    cd "${MSVC_BASE}"

    cat "${MSVC_BASE}_tmp/"*tgz* | tar xz

    rm -rf "${MSVC_BASE}_tmp"

    git clone https://github.com/Nemirtingas/windowscross_vcpkg "--branch=winsdk_${WINSDK_VER}" --depth=1 "${WINSDK_BASE}_tmp"

    cd "${WINSDK_BASE}"

    cat "${WINSDK_BASE}_tmp/"*tgz* | tar xz

    rm -rf "${WINSDK_BASE}_tmp"

    sudo ln -s ${INSTALL_PREFIX}/clang_windows_sdk/powershell /usr/bin/

fi

if [ ! -d ${INSTALL_PREFIX}/vcpkg ] ; then

    echo "Installing vcpkg..."

    git clone https://github.com/microsoft/vcpkg.git ${INSTALL_PREFIX}/vcpkg

    cp ${ORIG_WD}/x64-windows-clangcl.cmake ${INSTALL_PREFIX}/vcpkg/triplets/community/

    sudo ${INSTALL_PREFIX}/vcpkg/bootstrap-vcpkg.sh

else

    echo "Updating vcpkg ports..."
    cd ${INSTALL_PREFIX}/vcpkg
    git update --rebase

fi

cd ${ORIG_WD}

${INSTALL_PREFIX}/vcpkg/vcpkg install --disable-metrics --triplet=x64-windows-clangcl zlib
#${INSTALL_PREFIX}/vcpkg/vcpkg install --disable-metrics --triplet=x64-windows-clangcl openssl
${INSTALL_PREFIX}/vcpkg/vcpkg install --disable-metrics --allow-unsupported --triplet=x64-windows-clangcl qt
