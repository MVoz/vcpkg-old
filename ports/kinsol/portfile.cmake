include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://computing.llnl.gov/projects/sundials/download/kinsol-5.0.0-dev.2.tar.gz"
    FILENAME "kinsol-5.0.0-dev.2.tar.gz"
    SHA512 659dfcf395ad758853dfcafd3685442c6a15d3ecc8712d4cadc0b6ad7b4b7df0df69e603a6af7d78487ecac3f0b0e3e7eb8926e8217593663f78f384cf7aa767
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
