include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/sparsehash/sparsehash/commit/f93c0c69e959c1c77611d0ba8d107aa971338811"
    FILENAME "sparsehash.zip"
    SHA512 f7e30da4de1b265184ca85cc444d49d8a3756ee5a28d3c6787a034f8c5984c47390b89adcb98998295eced6f8e7a4d57cf8bbbd0fb9267ac024b7ac7f5130e01
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH sparsehash.sln
	LICENSE_SUBPATH COPYING
	USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
