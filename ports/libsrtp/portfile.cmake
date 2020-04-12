include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/cisco/libsrtp/archive/e8629b718d9efe1ccc254754ca33c88199e1bbf3.zip"
    FILENAME "e8629b718d9efe1ccc254754ca33c88199e1bbf3.zip"
    SHA512 4019cf1f8ad1e0a9020a17faaa88c2f4032ceb2941b42495588b4c334b6647783d4730eb56fad5187a7d788bec3b94294643bfcde65608128bc204946b3928ac
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
	NO_CHARSET_FLAG # automatic templates
#	GENERATOR "NMake Makefiles" # automatic templates
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
		-DINSTALL_HEADERS_TOOLS=OFF
		-DINSTALL_HEADERS=OFF
    OPTIONS_RELEASE 
        -DINSTALL_HEADERS=ON # automatic templates
#        -D =OFF
    OPTIONS 
        -DENABLE_DEBUG_LOGGING=OFF
        -DENABLE_OPENSSL=OFF
        -DERR_REPORTING_STDOUT=OFF
        -DGCM=OFF
        -DOPENSSL=OFF
        -DTEST_APPS=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
