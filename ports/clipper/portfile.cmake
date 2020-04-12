include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ziocleto/clipper/archive/9b7c998ead3a85bacf9ba91a172779a8efedf1b5.zip"
    FILENAME "clipper.zip"
    SHA512 e550780c7a7278edf68c64fc9fef26d9fef4cdb6b62baf4e03212ae2f3b2c9527a56dfd6f92172ce7d728072c0ac5f7e62deeeecc477e6b670b2a0735f76cc6e
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
configure_file(${SOURCE_PATH}/README ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
