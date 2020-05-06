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
    URLS "https://github.com/apache/httpd/archive/85e7abe5aff0c2e45a8784dacf500a95df92b766.zip"
    FILENAME "85e7abe5aff0c2e45a8784dacf500a95df92b766.zip"
    SHA512 442c360f85496c1d5feb2cce92e89fde3b6d70131fe6eeec395675aa4cbc6b116a1d86b09c24099af3bffcf5f3a159c2dfe4c85d312b023fa491eb258caa4fe2
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 

)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS 
		-DAPR_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include
		-DNGHTTP2_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include
		-DPCRE_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include
		-DLIBXML2_ICONV_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include
		-DBROTLI_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include
		-DCHECK_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include
		-DINSTALL_MANUAL=OFF		
		-DEXTRA_INCLUDES=${CURRENT_INSTALLED_DIR}/include
		-DOPENSSL_ROOT_DIR=${CURRENT_INSTALLED_DIR}
	OPTIONS_RELEASE
		-DEXTRA_LIBS="${CURRENT_INSTALLED_DIR}/lib/expat.lib"
		-DLIBXML2_ICONV_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/libiconv.lib
		-DLIBXML2_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/libxml2.lib
		-DNGHTTP2_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/nghttp2.lib
		-DPCRE_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/pcre.lib
		-DAPR_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/libapr-1.lib
#		-DNGHTTP2_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/nghttp2[d].lib
#		-DPCRE_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/pcre[d].lib
		-DCHECK_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/check.lib
		-DBROTLI_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/brotlicommon.lib
		-DLUA_LIBRARIESlib=${CURRENT_INSTALLED_DIR}/lua.lib
    OPTIONS_DEBUG
		-DEXTRA_LIBS="${CURRENT_INSTALLED_DIR}/debug/lib/expat.lib"
		-DAPR_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/libapr-1.lib
		-DLIBXML2_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/libxml2.lib
		-DLIBXML2_ICONV_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/libiconv.lib
		-DNGHTTP2_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/nghttp2d.lib
		-DPCRE_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/pcred.lib
		-DCHECK_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/check.lib
		-DBROTLI_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/brotlicommon.lib
		-DLUA_LIBRARIESlib=${CURRENT_INSTALLED_DIR}/debug/lua.lib
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libhttpd RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libhttpd)
