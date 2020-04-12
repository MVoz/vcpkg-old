include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/psyinf/gmtl/archive/9b3675459e0fd2d1a11d1af03994abcb8b69c9cf.zip"
    FILENAME "9b3675459e0fd2d1a11d1af03994abcb8b69c9cf.zip"
    SHA512 49c8c4857a0f9deae7de93412a30322a8aa07d1840ba47b760428b2552ff81cf4df5f5eabffe51e18f2c68b6530fdde14199658edf08e7cb1d2449c76a45cdb7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
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
