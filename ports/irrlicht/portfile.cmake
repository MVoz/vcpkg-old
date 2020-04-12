# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://downloads.sourceforge.net/project/irrlicht/Irrlicht%20SDK/1.8/1.8.4/irrlicht-1.8.4.zip"
    FILENAME "irrlicht-1.8.4.zip"
    SHA512 de69ddd2c6bc80a1b27b9a620e3697b1baa552f24c7d624076d471f3aecd9b15f71dce3b640811e6ece20f49b57688d428e3503936a7926b3e3b0cc696af98d1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF "1.8.4"
    # [NO_REMOVE_ONE_LEVEL]
    # [WORKING_DIRECTORY <${CURRENT_BUILDTREES_DIR}/src>]
    # [PATCHES <a.patch>...]
)

# Copy CMakeLists.txt to the source, because Irrlicht does not have one.
file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

set(FAST_MATH FALSE)
if("fast-fpu" IN_LIST FEATURES)
    set(FAST_MATH TRUE)
endif()

set(BUILD_TOOLS FALSE)
if("tools" IN_LIST FEATURES)
    set(BUILD_TOOLS TRUE)
endif()

set(SHARED_LIB TRUE)
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    set(SHARED_LIB FALSE)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS 
        -DIRR_SHARED_LIB=${SHARED_LIB} 
        -DIRR_FAST_MATH=${FAST_MATH}
        -DIRR_BUILD_TOOLS=${BUILD_TOOLS}
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()

if(BUILD_TOOLS)
    vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/irrlicht/)
endif()

file(WRITE ${CURRENT_PACKAGES_DIR}/share/irrlicht/irrlicht-config.cmake "include(\${CMAKE_CURRENT_LIST_DIR}/irrlicht-targets.cmake)")
# Handle copyright
file(WRITE ${CURRENT_PACKAGES_DIR}/share/irrlicht/copyright "
The Irrlicht Engine License
===========================

Copyright (C) 2002-2015 Nikolaus Gebhardt

This software is provided 'as-is', without any express or implied
warranty.  In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgement in the product documentation would be
   appreciated but is not required.
2. Altered source versions must be clearly marked as such, and must not be
   misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.")

vcpkg_copy_pdbs()

# Post-build test for cmake libraries
vcpkg_test_cmake(PACKAGE_NAME irrlicht)
