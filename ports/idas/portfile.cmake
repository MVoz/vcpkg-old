include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://computing.llnl.gov/projects/sundials/download/idas-4.0.0-dev.2.tar.gz"
    FILENAME "idas-4.0.0-dev.2.tar.gz"
    SHA512 ebf8a9aafe7541e60595c3cbbc1f1fd120dd2d3fc68d74950524bb81a7c7958e8493d3268089ebfdae7a8e05ac4ae69ff67a68835e9c9c2951e2e5ac0f1628e8
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
