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
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/opencascade-7.2.0)
vcpkg_download_distfile(ARCHIVE
    URLS "ftp://fulongkjftp:fulongkeji@svn.fulongtech.cn/SEAL/OpenSource/opencascade-7.2.0.tgz"
    FILENAME "opencascade-7.2.0.tgz"
    SHA512 d51a1d901d5a6afa2013ad5759c1d5e016af1b804b27ae611a3090a5fcb8bde34b646de92cf21cd3e221003322d17a044b14d8e54f44d056ed51e28df0ef5f67
)
vcpkg_extract_source_archive(${ARCHIVE}
)
vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES "${CMAKE_CURRENT_LIST_DIR}/fixed-link-tcl-tk.patch"
)

vcpkg_find_acquire_program(TCL)
get_filename_component(TCL_PATH ${TCL} DIRECTORY)
get_filename_component(TCL_PATH ${TCL_PATH} DIRECTORY)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS
        -D3RDPARTY_TCL_DIR=${TCL_PATH}
        -D3RDPARTY_TCL_INCLUDE_DIR=${TCL_PATH}/include
        -D3RDPARTY_TCL_LIBRARY_DIR=${TCL_PATH}/lib
        -D3RDPARTY_TCL_LIBRARY=${TCL_PATH}/lib/tcl86t.lib
        -D3RDPARTY_TCL_DLL_DIR=${TCL_PATH}/bin
        -D3RDPARTY_TCL_DLL=${TCL_PATH}/bin/tcl86t.dll
        -D3RDPARTY_TK_DIR=${TCL_PATH}
        -D3RDPARTY_TK_INCLUDE_DIR=${TCL_PATH}/include
        -D3RDPARTY_TK_LIBRARY_DIR=${TCL_PATH}/lib
        -D3RDPARTY_TK_LIBRARY=${TCL_PATH}/lib/tk86t.lib
        -D3RDPARTY_TK_DLL_DIR=${TCL_PATH}/bin
        -D3RDPARTY_TK_DLL=${TCL_PATH}/bin/tk86t.dll
        -DINSTALL_DIR_BIN=bin
        -DINSTALL_DIR_INCLUDE=include
        -DINSTALL_DIR_LIB=lib
    # OPTIONS_RELEASE -DBUILD_TYPE=Release
    # OPTIONS_DEBUG -DBUILD_TYPE=Debug -DOCCT_INSTALL_BIN_LETTER=d
)

# set(_VCPKG_CMAKE_GENERATOR "Ninja")
vcpkg_install_cmake()

file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bind ${CURRENT_PACKAGES_DIR}/debug/bin)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/libd ${CURRENT_PACKAGES_DIR}/debug/lib)

file(REMOVE_RECURSE
    ${CURRENT_PACKAGES_DIR}/data
    ${CURRENT_PACKAGES_DIR}/samples
    ${CURRENT_PACKAGES_DIR}/src
    ${CURRENT_PACKAGES_DIR}/debug/data
    ${CURRENT_PACKAGES_DIR}/debug/include
    ${CURRENT_PACKAGES_DIR}/debug/samples
    ${CURRENT_PACKAGES_DIR}/debug/src)

file(GLOB NEED_REMOVE_FILES
    ${CURRENT_PACKAGES_DIR}/bin/*.exe
    ${CURRENT_PACKAGES_DIR}/*.bat
    ${CURRENT_PACKAGES_DIR}/*.txt
    ${CURRENT_PACKAGES_DIR}/debug/bin/*.exe
    ${CURRENT_PACKAGES_DIR}/debug/*.bat
    ${CURRENT_PACKAGES_DIR}/debug/*.txt)

file(REMOVE ${NEED_REMOVE_FILES})

file(RENAME ${CURRENT_PACKAGES_DIR}/cmake ${CURRENT_PACKAGES_DIR}/lib/OpenCASCADE)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/cmake ${CURRENT_PACKAGES_DIR}/debug/lib/OpenCASCADE)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE_LGPL_21.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/opencascade)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/opencascade/LICENSE_LGPL_21.txt ${CURRENT_PACKAGES_DIR}/share/opencascade/copyright)
