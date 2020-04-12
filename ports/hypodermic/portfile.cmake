include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Omnirobotic/Hypodermic/archive/develop.zip"
    FILENAME "Hypodermic-0.zip"
    SHA512 47fbbe32804a8a1f94125a04dc85ab12c0e5e9384dbdb6291c99a528c2dd8ebc5d86fe0e450c37c2ef543668552e0fee0c47fe924d5e1d3c13fed2d0cf28448b
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
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
