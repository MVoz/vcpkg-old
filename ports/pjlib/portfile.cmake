include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/pjsip/pjproject/archive/34d306362742dd535b9b8ae80d836ab5e39def93.zip"
    FILENAME "pjlib.zip"
    SHA512 401489ba8a33e7c8887a6c2044d73a50b114911bb9fda35adb3e45095c5ee4e2167297d2c0ef387d5930f869fae696f73fcf8a319c28df0ff44321f4b74dc807
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${SOURCE_PATH}/pjlib/include/pj/config_site_sample.h DESTINATION ${CURRENT_PACKAGES_DIR}/pjlib/include/pj/config_site.h)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "pjlib/build/pjlib.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    INCLUDES_SUBPATH pjlib/include ALLOW_ROOT_INCLUDES
    USE_VCPKG_INTEGRATION
)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/pjlib)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
