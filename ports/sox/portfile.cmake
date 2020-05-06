include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://datapacket.dl.sourceforge.net/project/sox/sox/14.4.2/sox-14.4.2.tar.bz2"
    FILENAME "sox-14.4.2.tar.bz2"
    SHA512 424b80e9fff43864b0581fea7a231b8308bdebb2aee0b97cc40eeaa347c093e94bcd0111e8b431e7bfe88b3c1133660ede42b6b49d14555ea0626c2c0ffa308e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/sox RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME sox)
