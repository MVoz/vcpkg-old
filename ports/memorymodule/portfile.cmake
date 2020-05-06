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

# https://mesonbuild.com/Configuring-a-build-directory.html
#vcpkg_configure_meson(
#	SOURCE_PATH ${SOURCE_PATH}
#    OPTIONS
#		--backend=ninja
#)

#vcpkg_install_meson()

include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/fancycode/MemoryModule/archive/5f83e41c3a3e7c6e8284a5c1afa5a38790809461.zip"
    FILENAME "5f83e41c3a3e7c6e8284a5c1afa5a38790809461.zip"
    SHA512 266f2eb5728d4b01fbf80d35ad5b94d198f6ac2f02b33b7c8979c890a6ce2c32fb234da9489bd7681ea1213457b579ed3ade401e02f00f97ac8374991300e87a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#        001_port_fixes.patch
#        002_more_port_fixes.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    OPTIONS 
#        -D =ON
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =ON
#        -D =OFF
#    OPTIONS_DEBUG
#        -D =ON
#        -D =OFF
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/memorymodule RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME memorymodule)
