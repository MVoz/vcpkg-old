include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Voskrese/mxml/archive/4b035226ac1f4ae2f47f91b08fd30371d5c2604e.zip"
    FILENAME "mxml.zip"
    SHA512 ee6d19fb6434b713e8c5af1a9f57160f549f265e07baf4db46459b87925daf2f4bba900b673fd2a10a8a3bd5d21c18b9c76ab0c23dec8bc3461d005cfbca5b26
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "vcnet/mxml.sln"
    SKIP_CLEAN
    LICENSE_SUBPATH LICENSE
    USE_VCPKG_INTEGRATION
)

file(COPY ${SOURCE_PATH}/mxml.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
