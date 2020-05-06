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
set(SOURCE_VERSION 1.1.1)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/dlfcn-win32-${SOURCE_VERSION})
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/dlfcn-win32/dlfcn-win32/archive/1488731c810ed76589170909da9ef07f060cef46.zip"
    FILENAME "dlfcn-win32.zip"
    SHA512 e01a2714f9e52b14146e53eb03e6a1e924d512c15da01b9fdbe9022a1eff3ae2b517a095b7ebe432c8ca4fa97a49944bc3abcff7de0c164ca5864bc3d1620a7d
)
vcpkg_extract_source_archive(${ARCHIVE})

#option(BUILD_SHARED_LIBS "shared/static libs" ON) 

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

file(READ ${CURRENT_PACKAGES_DIR}/debug/share/dlfcn-win32/dlfcn-win32-targets-debug.cmake dlfcn-win32_DEBUG_MODULE)
string(REPLACE "\${_IMPORT_PREFIX}" "\${_IMPORT_PREFIX}/debug" dlfcn-win32_DEBUG_MODULE "${dlfcn-win32_DEBUG_MODULE}")
file(WRITE ${CURRENT_PACKAGES_DIR}/share/dlfcn-win32/dlfcn-win32-targets-debug.cmake "${dlfcn-win32_DEBUG_MODULE}")

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

vcpkg_copy_pdbs()

# Handle copyright
file(COPY ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/dlfcn-win32)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/dlfcn-win32/COPYING ${CURRENT_PACKAGES_DIR}/share/dlfcn-win32/copyright)
