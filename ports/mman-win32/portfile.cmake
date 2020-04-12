include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/witwall/mman-win32/archive/9f115ad0b4c03e9356f5dd596deda0da6729a257.zip"
    FILENAME "9f115ad0b4c03e9356f5dd596deda0da6729a257.zip"
    SHA512 8dc525c57918257622b6618ad8beb7c7a293bae1673590ac0f11ba7c80ed7d2a5c570c903baf6c9d97124e9a1310d7da83a3f42219a967a3ec3ec97c44778ddb
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

# Handle copyright
file(INSTALL ${SOURCE_PATH}/README.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/mman-win32 RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME mman-win32)
