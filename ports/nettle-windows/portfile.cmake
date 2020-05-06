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
    URLS "https://github.com/ShiftMediaProject/nettle/archive/nettle_3.4.1_release_20181204.zip"
    FILENAME "nettle_3.4.1_release_20181204.zip"
    SHA512 80af2c86457108d771da16c4ba39df79a97f8168c58f601f669cba42812b01970eed87409a7659e0e3da2643ededd1ab500e58f060921075ece1039950d1bde1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
    # (Optional) A friendly name to use instead of the filename of the archive (e.g.: a version number or tag).
    # REF 1.0.0
    # (Optional) Read the docs for how to generate patches at: 
    # https://github.com/Microsoft/vcpkg/blob/master/docs/examples/patching.md
    # PATCHES
    #   001_port_fixes.patch
    #   002_more_port_fixes.patch
)

vcpkg_install_msbuild(
	CURRENT_BUILDTREES_DIR ${SOURCE_PATH}
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH SMP/libnettle.sln
#	PROJECT_PATH gperftools.sln
#	RELEASE_CONFIGURATION Release-Override
#	DEBUG_CONFIGURATION Debug
#	USE_VCPKG_INTEGRATION
	USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/nettle-windows RENAME copyright)

# Post-build test for cmake libraries
# ## vcpkg_test_cmake(PACKAGE_NAME nettle-windows)
