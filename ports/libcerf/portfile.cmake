include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://jugit.fz-juelich.de/mlz/libcerf/-/archive/721e32cf4f2f25c4b4323984dfe61b0760ff3b6a/libcerf-721e32cf4f2f25c4b4323984dfe61b0760ff3b6a.tar.gz"
    FILENAME "libcerf-721e32cf4f2f25c4b4323984dfe61b0760ff3b6a.tar.gz"
    SHA512 5ba9ea293248c86b08fabcfc775b6ef5ffe4217516c174ba42107a91b8a1845b58822317fe61be1495dab83275c407677fcf602fde3d2cbf5dc91cb3c006a634
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
        -DCERF_CPP=ON
		-DBUILD_TESTING:BOOL=OFF
		-DLIB_MAN:BOOL=OFF
		-DLIB_RUN:BOOL=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
