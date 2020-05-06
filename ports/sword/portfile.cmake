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

if(NOT VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
    message(FATAL_ERROR "\n-- CURRENT port ${PORT} only be built for x86 currently"
	"\n-- "
	)
endif()

if(NOT VCPKG_CMAKE_SYSTEM_NAME)
    message(FATAL_ERROR "\n-- CURRENT port ${PORT} only be built for Windows Desktop currently"
	"\n-- "
	)
endif()

MESSAGE(STATUS "\n-- CURRENT port ${PORT} REQUIRED ICU ver.5.3 http://download.icu-project.org/files/icu4c/53.1/"
	"\n--"
)

vcpkg_download_distfile(ARCHIVE
    URLS "https://www.crosswire.org/ftpmirror/pub/sword/source/sword.tar.gz"
    FILENAME "sword.tar.gz"
    SHA512 acac8be1b2dbafda4faf071cbb7b042ec40cef8334f13042ff3b5ce8fb80db5f541bc3187ee98a9d8451cc0ca65f24dc6655ad698172b3f6cb5f3d5a4d576df0
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

#patch https://github.com/Microsoft/vcpkg/blob/master/docs/maintainers/vcpkg_apply_patches.md
if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    vcpkg_apply_patches(
        SOURCE_PATH ${SOURCE_PATH}
#		SOURCE_PATH ${CURRENT_PACKAGES_DIR}/include
#		PATCHES "${CMAKE_CURRENT_LIST_DIR}/shared.patch")
#		PATCHES "${CMAKE_CURRENT_LIST_DIR}/build-shared-lib.patch"
		PATCHES 
			"${CMAKE_CURRENT_LIST_DIR}/patch-sword.patch"
        QUIET
    )
else()
    vcpkg_apply_patches(
        SOURCE_PATH ${SOURCE_PATH}
#		PATCHES "${CMAKE_CURRENT_LIST_DIR}/build-static-lib.patch"
		PATCHES 
			"${CMAKE_CURRENT_LIST_DIR}/patch-sword.patch"
			"${CMAKE_CURRENT_LIST_DIR}/patch-sword-static.patch"
        QUIET
    )
endif()

vcpkg_install_msbuild(#	CURRENT_BUILDTREES_DIR ${SOURCE_PATH}
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH lib/vcppmake/libsword.sln
	USE_VCPKG_INTEGRATION
)

# Install the headers
set(SOURCE_PATH ${SOURCE_PATH})
set(CMAKE_CURRENT_BINARY_DIR ${SOURCE_PATH})

vcpkg_replace_string(
    ${SOURCE_PATH}/cmake/sources.cmake
    "	include/"
    " ${SOURCE_PATH}/include/"
)
vcpkg_replace_string(
    ${SOURCE_PATH}/cmake/sources.cmake
    "SOURCE_GROUP"
    "## SOURCE_GROUP"
)

include(${SOURCE_PATH}/cmake/sources.cmake)

file(COPY ${SWORD_INSTALL_HEADERS}
	DESTINATION ${CURRENT_PACKAGES_DIR}/include/sword
)

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/sword RENAME copyright)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/sword RENAME license)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/sword RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME sword)
