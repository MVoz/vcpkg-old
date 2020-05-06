include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/metabrainz/libdiscid/archive/073a568568032364bfae38872e117c1ffac4cb83.zip"
    FILENAME "libdiscid-0.zip"
    SHA512 24747142236bc2a1357ac08277248e58ea6b469829e798782a3a36a83da4baf59fdf9b7cc4fc15b5991ad738dc38721a0822be9d84e75fc5b9a32ee44c73f539
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
	NO_CHARSET_FLAG # automatic templates
#    OPTIONS 
#		-DBUILD_TESTS=OFF
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
