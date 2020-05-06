include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.linphone.org/BC/public/external/libxsd/-/archive/bc/libxsd-bc.tar.gz"
    FILENAME "libxsd-bc.tar.gz"
    SHA512 05072d3e63c5a3295db6530c2031bf5be1f6f689499dada8ec4d846f76aa793ed81c6188520cc3903a139e60ca0d145c5b931875a96e8f70e71e9456e7a43c53
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
