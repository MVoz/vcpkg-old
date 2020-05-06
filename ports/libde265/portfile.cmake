include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/strukturag/libde265/archive/9ffb59c2d51c53bd6d06a07b842d0cc0365a232d.zip"
    FILENAME "9ffb59c2d51c53bd6d06a07b842d0cc0365a232d.zip"
    SHA512 b1556034022874e96f64ee1411e83110ba743786001714cd6cf90cf5b6d44ef91b986759de8f8586ec19056240e16902b99fbbfddff1c99b6393ec7099bda081
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
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
