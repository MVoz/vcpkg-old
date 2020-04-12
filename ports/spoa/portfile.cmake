include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/rvaser/spoa/archive/0b9e56da3241d6a887d64adcfd1ebfae29810c04.zip"
    FILENAME "0b9e56da3241d6a887d64adcfd1ebfae29810c04.zip"
    SHA512 a35288c2979c6325a3cfbecbf2f51bf71c4961ba41a708462cec02e873ff142e228ff0da4dc53bfb56ec5100c1bceb21de85fbc5cac303d557ec8d13e62e084f
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      001_spoa_patch.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
