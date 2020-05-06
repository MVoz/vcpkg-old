include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/nu774/cafmux/archive/46990bedf594459e148fb8d9df345d8e600a32d3.zip"
    FILENAME "cafmux.zip"
    SHA512 85c786ef803b8e7b3db8181cd993ec6b309fb4ba3ca477a5b7397e115fd2592dddc7ba2e550c5770e1d70ca82abfc2152018f273d323ee2c5ed1115b3f4814be
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "cafmux.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH README.rst
    USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
