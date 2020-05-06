include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/nu774/libsoxrate/archive/f447ead7f29faa1af482a39baa63a39d59d56bbd.zip"
    FILENAME "f447ead7f29faa1af482a39baa63a39d59d56bbd.zip"
    SHA512 b1a474b6be54d48b096e48f09a2a1b02164e9ce4553fce4b449927faea72994a84a007b18b86268d8920b5234f00b44a80d68d33b59325ef639deced0918aa5e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "libsoxrate.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

file(COPY ${SOURCE_PATH}/libsoxrate.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
