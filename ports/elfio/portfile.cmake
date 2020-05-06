include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/avast/elfio/archive/f85f07390b756fee61408dfe0b04ae4fb86c5477.zip"
    FILENAME "f85f07390b756fee61408dfe0b04ae4fb86c5477.zip"
    SHA512 e770e2c66da4e23a970a7d59ad8785b6503ec19c757119c578a2f9582896686569372933dc8de2b8df4e6d039a097b6cc526d639f13c0462ac34142c941351cf
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

file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/elfio RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME elfio)
