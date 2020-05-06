include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/zeux/meshoptimizer/archive/dafcb200c2e38f3bb428bba69a618eaa7edfc74b.zip"
    FILENAME "meshoptimizer.zip"
    SHA512 d42be2837e7ed554f0d1c5651694315cc8985cbf109ba34e0192e2a1c57fb282069f9ca87a52fe59d9c6296824ddbee9c251254b902a271b119b3ad506c9cf22
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
#      -D =OFF # automatic templates
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
