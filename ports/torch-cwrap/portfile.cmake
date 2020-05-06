# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "LuaJIT currently only supports being built for desktop")
endif()

set(GIT_NAME cwrap)
set(GIT_REF dbd0a623dc4dfb4b8169d5aecc6dd9aec2f22792)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${GIT_NAME}-${GIT_REF})

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO torch/${GIT_NAME}
    REF ${GIT_REF}
    SHA512 437bda2d70f9fb8051fc4dc3668a21733a940fbd6f517413f6b0eaeaf68844eefdd80b38296ca904ac4ec15a621dec8fb3a4b413d18848e8e2d1056001d663fa
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    GENERATOR "NMake Makefiles"
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS -DLUADIR=${CURRENT_PACKAGES_DIR}/lua
)

set(_VCPKG_CMAKE_GENERATOR "NMake")
vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lua)

file(INSTALL ${SOURCE_PATH}/COPYRIGHT.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/torch-cwrap RENAME copyright)

SET(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)