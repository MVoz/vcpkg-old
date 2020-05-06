include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ennorehling/dlmalloc/archive/f1446c47ca1774ae84bf86a28502e91daf6b421a.zip"
    FILENAME "f1446c47ca1774ae84bf86a28502e91daf6b421a.zip"
    SHA512 1b620806f820555550b29000da1cddfd1d403c862bcf769f920ba22709fafdb8d841a02510f577f8420ffe5f1ebb82e32171cd1ee76cf4086dde6ac7d980c560
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

configure_file(${SOURCE_PATH}/README ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
vcpkg_copy_pdbs()