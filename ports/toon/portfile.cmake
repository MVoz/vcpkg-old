include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/seichter/TooN/archive/c274ede5a21559c6aaf82769f530195db64bc4f4.zip"
    FILENAME "c274ede5a21559c6aaf82769f530195db64bc4f4.zip"
    SHA512 14b7bf022d5f5b096c1a3cd3e8ae3f09fb8cf929162e97e29e480f7e3f8b0023b68213f08c9f4760d6682438073965130e97833f577301b0c0b5057a7126c09c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${SOURCE_PATH}/internal DESTINATION ${CURRENT_PACKAGES_DIR}/include/toon)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
