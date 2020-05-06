# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   CMAKE_CURRENT_LIST_DIR    = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)

#string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" KEYSTONE_BUILD_STATIC)
#string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" KEYSTONE_BUILD_SHARED)
#vcpkg_configure_cmake(
#    SOURCE_PATH ${SOURCE_PATH}
#    PREFER_NINJA
#    OPTIONS
#        -DKEYSTONE_BUILD_STATIC=${KEYSTONE_BUILD_STATIC}
#        -DKEYSTONE_BUILD_SHARED=${KEYSTONE_BUILD_SHARED}
#)
#string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" CURL_STATICLIB)
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY) ## = ## VCPKG_LIBRARY_LINKAGE=static ## = ## BUILD_STATIC_LIBS=ON
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY ONLY_DYNAMIC_CRT)
#vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)
#vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY ONLY_DYNAMIC_CRT)
###

include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/gpac-buildbot/AMR_WB_FT/archive/692fbf4148bfc34f28d3d7ebefd4b7c96df00544.zip"
    FILENAME "692fbf4148bfc34f28d3d7ebefd4b7c96df00544.zip"
    SHA512 4dfcc96f4a57e3e4a12eab8c9018e172bff4a2edadfe041cb910cc61b8b77243502f5779f789d29e0c40d80ca4f7796d62fc3049dba477cb42c0cb6553c0441e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "build/win32/libxvidcore.vcxproj"
	SKIP_CLEAN
	LICENSE_SUBPATH LICENSE
	USE_VCPKG_INTEGRATION
)

#file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR}/include RENAME a52dec)

#file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR}/include)
#file(RENAME ${CURRENT_PACKAGES_DIR}/include/include ${CURRENT_PACKAGES_DIR}/include/a52dec) 

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
