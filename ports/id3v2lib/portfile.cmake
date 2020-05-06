include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/corporateshark/PortAMP/archive/fe087e82c283b59f34064b7478288c0ca61597b7.zip"
    FILENAME "id3v2lib.zip"
    SHA512 68c80ba1e41820a00cd10eaecd006f3a6a8ba22baa085df4d6a3bded8d9c8b02df4692d1739f4018de5dd9368e2cd032c713b18b71471ecb9f614a1f0fecaf4d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      001_patch.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/libs/id3v2lib
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
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
