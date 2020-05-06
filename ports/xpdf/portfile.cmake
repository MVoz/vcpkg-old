include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://xpdfreader-dl.s3.amazonaws.com/xpdf-4.01.01.tar.gz"
    FILENAME "xpdf-4.01.01.tar.gz"
    SHA512 e0b42195ba4858ecf2ec3c3c06a42eae742eb8567dca695a45a01185b606b399b5e45d220b24ed39782d1f9b1ee16f674129db3346d25b709bbb3f90ef078c22
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

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
vcpkg_copy_pdbs()
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/${PORT})
vcpkg_copy_tool_deps(${CURRENT_PACKAGES_DIR}/tools/${PORT})
###
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)