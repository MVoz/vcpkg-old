include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ncbi/ngs/archive/c014203409d3daaa96d0a41c93fd3cca92ad7e30.zip"
    FILENAME "ngs-sdk.zip"
    SHA512 ab9e53f5463a74f9e5a1854860e2da51a6db77d937dd1e706dfd4c8430b2c791cceb05c8bf5b3e859f34dde62490d64b79fd9461dbda13f08c289d8121f23732
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "ngs-sdk/win/vs2017/ngs-sdk.sln"
    SKIP_CLEAN
    LICENSE_SUBPATH LICENSE
    INCLUDES_SUBPATH ngs-sdk/ngs ALLOW_ROOT_INCLUDES
    USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
