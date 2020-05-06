include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/yasm/yasm/archive/bcc01c59d8196f857989e6ae718458c296ca20e3.zip"
    FILENAME "yasm.zip"
    SHA512 f8b5f5df104b8a6c839732822bd89e08c11b9ad0875a3e889ff0ce09c2cd4235b31805632f311323a48dded8e54a141826aa5eaaa1e26b9e5d858b5ecb754552
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
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
